package com.tnmeta.torymeta.campus

import android.annotation.SuppressLint
import android.graphics.Color
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.DialogFragment
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.fragment.findNavController
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.LinearSmoothScroller
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.google.android.material.tabs.TabLayout
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseFragment
import com.tnmeta.torymeta.campus.model.AvatarCategoryData
import com.tnmeta.torymeta.campus.viewmodel.AvatarViewModel
import com.tnmeta.torymeta.campus.model.CategoryType
import com.tnmeta.torymeta.campus.model.ColorData
import com.tnmeta.torymeta.campus.model.ColorType
import com.tnmeta.torymeta.common.Constants
import com.tnmeta.torymeta.common.ToryMetaMessageType
import com.tnmeta.torymeta.common.ToryMetaSceneParam
import com.tnmeta.torymeta.databinding.AvatarListItemBinding
import com.tnmeta.torymeta.databinding.ColorListItemBinding
import com.tnmeta.torymeta.databinding.FragmentToryAvatarProfileBinding
import com.tnmeta.torymeta.dialog.BuyItemsBottomDialogFragment
import com.tnmeta.torymeta.dialog.SortFilterBottomDialogFragment
import com.tnmeta.torymeta.model.BaseParam
import com.tnmeta.torymeta.model.unity.avatar.AvatarCategorySortyType
import com.tnmeta.torymeta.model.unity.avatar.info.SwitchSceneSimple
import com.tnmeta.torymeta.model.dto.myAvatar.AvataModel
import com.tnmeta.torymeta.model.dto.myAvatar.AvatarBuyItem
import com.tnmeta.torymeta.model.dto.myAvatar.AvatarColorDTO
import com.tnmeta.torymeta.model.dto.myAvatar.AvatarModelingDTO
import com.tnmeta.torymeta.ui.CommonAlertDialog
import com.tnmeta.torymeta.unity.UnityUtils
import io.reactivex.rxjava3.kotlin.subscribeBy
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import timber.log.Timber
import java.text.DecimalFormat



class ToryAvatarProfileFragment : BaseFragment(), View.OnClickListener {
    companion object {
        val TAG : String = ToryAvatarProfileFragment::class.java.simpleName

        fun newInstance() =
            ToryAvatarProfileFragment().apply {}

        private const val LIST_SPAN_COUNT = 4
    }

    private var _viewBinding: FragmentToryAvatarProfileBinding? = null
    private val viewBinding get() = _viewBinding!!

    private lateinit var viewModel: AvatarViewModel
    private val avatarCategoryArrayList     = ArrayList<AvatarModelingDTO>()
    private val avatarColorArrayList        = ArrayList<AvatarColorDTO>()

    private lateinit var mAdapter: RecyclerViewAdapter

    private var selectCaegoryPosition = -1
    private var selectCategoryType = CategoryType.HAIR
    private var mSortType = AvatarCategorySortyType.SORT_BASIC

    private var selectColorPosition = -1

    private lateinit var mColorSelectAdapter : ColorSelectAdapter


    private var selectCategoryArray : Array<AvataModel> = Array(5){
        AvataModel()
    }

    private val categoryMenuArray: Array<AvatarCategoryData> by lazy {
        arrayOf(
            AvatarCategoryData(CategoryType.HAIR, CategoryType.HAIR.name.lowercase(), R.string.avatar_category_hair),
            AvatarCategoryData(CategoryType.FACE, CategoryType.FACE.name.lowercase(), R.string.avatar_category_face),
            AvatarCategoryData(CategoryType.TOP, CategoryType.TOP.name.lowercase(), R.string.avatar_category_top),
            AvatarCategoryData(CategoryType.BOTTOM, CategoryType.BOTTOM.name.lowercase(), R.string.avatar_category_bottom),
            AvatarCategoryData(CategoryType.SHOES, CategoryType.SHOES.name.lowercase(), R.string.avatar_category_shoes)
        )
    }

    private val colorMenuArray : Array<ColorData> by lazy {
        arrayOf(
            ColorData(ColorType.HAIR, ColorType.HAIR.name.lowercase()),
            ColorData(ColorType.SKIN, ColorType.SKIN.name.lowercase())
        )
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        try {
            _viewBinding = FragmentToryAvatarProfileBinding.inflate(inflater, container, false)
            viewModel = ViewModelProvider(this)[AvatarViewModel::class.java]

            viewBinding.apply {

                if (UnityUtils.getPlayer().parent != null) {
                    (UnityUtils.getPlayer().parent as ViewGroup).removeAllViews()
                }

                UnityUtils.createPlayer(requireActivity()) {
                    UnityUtils.addUnityViewToGroup(unity)
                }

                val values =  SwitchSceneSimple(scene = ToryMetaSceneParam.SelectView)
                sendNativeUnityMessage(type = ToryMetaMessageType.SwitchSceneSimple,
                                        valueParam = values)

            }

            return viewBinding.root
        }catch (e : Exception){
            Timber.tag(TAG).d("error" + e.message)
        }

        return null
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewBinding.apply {

            initSetAvatar()

            initAvatarList()

            imgRotation.setOnClickListener {
                sendNativeUnityMessage(type = ToryMetaMessageType.AvatarRotate,
                                        valueParam = null)
            }

            arrayOf(ivBack, imgSort, colorSelect, colorSelectBotttom, reset, save, buyInfoLayout).forEach {
                it.setOnClickListener(this@ToryAvatarProfileFragment)
            }

            categoryTab.apply {
                for(item in categoryMenuArray) {
                    addTab(newTab().setText(item.titleResId))
                }
            }
            viewModel.apply {
                point.observe(viewLifecycleOwner) { point ->
                    myMemeberPoint.text = String.format("%s", DecimalFormat("#,###").format(point.mileage))
                }

                getAvatarCategory(categoryMenuArray[selectCategoryType.ordinal].categoryName.lowercase())
                getAvatarColor(colorMenuArray[selectCategoryType.ordinal].colorName.lowercase())

                categoryTab.addOnTabSelectedListener(object : TabLayout.OnTabSelectedListener{
                    override fun onTabSelected(tab: TabLayout.Tab?) {
                        Timber.tag(TAG).d("onTabSelected " + tab?.position)

                        selectCaegoryPosition = -1
                        //loadingProgress.visibility = View.VISIBLE
                        getAvatarCategory(categoryMenuArray[tab?.position!!].categoryName.lowercase())

                        colorSelect.visibility = View.GONE
                        colorSelectLayout.visibility = View.GONE

                        when(tab?.position) {
                            0 -> {
                                selectCategoryType = CategoryType.HAIR
                                getAvatarColor(colorMenuArray[tab?.position!!].colorName.lowercase())
                                colorSelect.visibility = View.VISIBLE
                            }

                            1 -> {
                                selectCategoryType = CategoryType.FACE
                                getAvatarColor(colorMenuArray[tab?.position!!].colorName.lowercase())
                                colorSelect.visibility = View.VISIBLE
                            }

                            2 -> selectCategoryType = CategoryType.TOP

                            3 -> selectCategoryType = CategoryType.BOTTOM

                            4 -> selectCategoryType = CategoryType.SHOES

                        }
                    }

                    override fun onTabUnselected(tab: TabLayout.Tab?) {}
                    override fun onTabReselected(tab: TabLayout.Tab?) {}
                })
            }
        }
    }


    private fun initAvatarList() = viewBinding.apply{

        repository.myAvatarAttr.value!!.apply {
            selectCategoryArray[0].colorCode = hairColorCode
            selectCategoryArray[1].colorCode = skinColorCode
        }

        mAdapter = RecyclerViewAdapter()

        avatarList.apply {
            layoutManager = GridLayoutManager(requireContext(), LIST_SPAN_COUNT)
            adapter = mAdapter
        }

        mColorSelectAdapter = ColorSelectAdapter()
        colorSelectRecycleView.apply {
            layoutManager = LinearLayoutManager(requireContext())
            adapter = mColorSelectAdapter
        }

        viewModel.apply {

            avatarCategoryList.observe(requireActivity()) { datas ->
                //loadingProgress.visibility = View.GONE
                avatarCategoryArrayList.apply {
                    clear()
                    addAll(datas)
                }

                val item = selectCategoryArray[selectCategoryType.ordinal]
                val index = avatarCategoryArrayList.indexOfFirst { it.id == item.id }
                if(index >= 0) {
                    val mySelectCategory = avatarCategoryArrayList[index]
                    mySelectCategory.isSelect = true
                    avatarCategoryArrayList[index] = mySelectCategory
                    selectCaegoryPosition = index

                }else {
                    repository.myAvatarAttr.value!!.apply {
                        val code = when(selectCategoryType) {
                            CategoryType.HAIR -> hairCode
                            CategoryType.FACE -> faceCode
                            CategoryType.TOP -> topCode
                            CategoryType.BOTTOM -> bottomCode
                            CategoryType.SHOES -> shoesCode
                        }

                        val index = avatarCategoryArrayList.indexOfFirst {
                            it.modelingCode == code
                        }

                        if(index >= 0) {
                            selectCategoryArray[selectCategoryType.ordinal].apply {
                                modelingCode = avatarCategoryArrayList[index].modelingCode
                                isOwned      = avatarCategoryArrayList[index].isOwned
                                isWear       = true
                            }

                            avatarCategoryArrayList[index].apply {
                                isSelect = true
                                isDefaultSelect = true
                            }
                            selectCaegoryPosition = index

                        }
                    }
                }

                if(selectColorPosition > 0) {
                    CoroutineScope(Dispatchers.Main).launch {
                        val smoothScroller: RecyclerView.SmoothScroller by lazy {
                            object : LinearSmoothScroller(requireContext()) {
                                override fun getVerticalSnapPreference() = SNAP_TO_START
                            }
                        }
                        smoothScroller.targetPosition = selectCaegoryPosition
                        viewBinding.avatarList.layoutManager?.startSmoothScroll(smoothScroller)
                    }
                }
                mAdapter.notifyDataSetChanged()
            }

            avatarColorList.observe(requireActivity()) { datas ->
                avatarColorArrayList.apply {
                    clear()
                    addAll(datas)
                }
                val item = selectCategoryArray[selectCategoryType.ordinal]
                val index = avatarColorArrayList.indexOfFirst { it.colorCode == item.colorCode }
                if(index >= 0) {
                    val selectColor = avatarColorArrayList[index]
                    selectColor.isSelect = true
                    avatarColorArrayList[index] = selectColor
                    selectColorPosition = index

                }else {
                    repository.myAvatarAttr.value!!.apply {
                        val color = when(selectCategoryType) {
                            CategoryType.FACE -> skinColorCode
                            CategoryType.HAIR -> hairColorCode
                            else -> 0
                        }

                        val index = avatarColorArrayList.indexOfFirst {
                            it.colorCode == color
                        }

                        if(index in 0..1) {
                            selectCategoryArray[selectCategoryType.ordinal].apply {
                                colorCode = avatarColorArrayList[index].colorCode
                            }
                            avatarColorArrayList[index].isSelect = true
                            selectColorPosition = index
                        }
                    }
                }
                Timber.tag(TAG).d(" avatarColorArrayList  %s", avatarColorArrayList.toString())
                mColorSelectAdapter.notifyDataSetChanged()
            }
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _viewBinding = null
    }

    override fun onResume() {
        super.onResume()
        try {
            UnityUtils.resume()
        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    override fun onPause() {
        super.onPause()
        try {
            UnityUtils.pause()
        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    override fun onClick(view: View) {
        when(view.id) {
            R.id.ivBack -> goToMain()

            R.id.img_sort -> {
                SortFilterBottomDialogFragment(requireContext(), mSortType).apply {
                    setStyle(DialogFragment.STYLE_NORMAL, R.style.AppBottomSheetDialogTheme)
                    onClickListener = { data ->

                        onCategorySort(data as AvatarCategorySortyType)
                    }
                    show(this@ToryAvatarProfileFragment.childFragmentManager, Constants.EventBottomDialogFragmentTag)
                }
            }

            R.id.colorSelect -> {
                viewBinding.apply {
                    colorSelect.visibility = View.GONE
                    colorSelectLayout.visibility = View.VISIBLE
                }
            }

            R.id.colorSelectBotttom -> {
                viewBinding.apply {
                    colorSelect.visibility = View.VISIBLE
                    colorSelectLayout.visibility = View.GONE
                }
            }

            R.id.reset -> {
                val selectCount = selectCategoryArray.count {
                    it.id != -1
                }

                if(selectCount > 0 ) {
                    CommonAlertDialog.Builder(this@ToryAvatarProfileFragment.requireContext())
                        .setMessage(R.string.avatar_reset_message)
                        .setNegativeButton(R.string.system_alert_btn_cancel) {}
                        .setPositiveButton(R.string.system_alert_btn_ok) {
                            onAvatarReset()
                        }
                        .show()
                }else {
                    repository.myAvatarAttr!!.value?.apply {
                        if(selectCategoryArray[0].colorCode != hairColorCode || selectCategoryArray[1].colorCode != skinColorCode) {
                            CommonAlertDialog.Builder(this@ToryAvatarProfileFragment.requireContext())
                                .setMessage(R.string.avatar_reset_message)
                                .setNegativeButton(R.string.system_alert_btn_cancel) {}
                                .setPositiveButton(R.string.system_alert_btn_ok) {
                                    onAvatarReset()
                                }
                                .show()
                        }
                    }
                }
            }

            R.id.save -> {

                if(repository.hasAvatarAttrYn == Constants.NoValue) {
                    val ownedCount = selectCategoryArray.count {
                        it.isOwned == 1 && !it.isWear
                    }

                    if (ownedCount > 0) {
                        CommonAlertDialog.Builder(this@ToryAvatarProfileFragment.requireContext())
                            .setMessage(R.string.avatar_select_category_change)
                            .setNegativeButton(R.string.system_alert_btn_cancel) {}
                            .setPositiveButton(R.string.system_alert_btn_ok) {
                                onBuy(false)
                            }
                            .show()
                    } else {

                        CommonAlertDialog.Builder(this@ToryAvatarProfileFragment.requireContext())
                            .setMessage(R.string.avatar_select_category_change)
                            .setNegativeButton(R.string.system_alert_btn_cancel) {}
                            .setPositiveButton(R.string.system_alert_btn_ok) {
                                onDefaultSave()
                            }
                            .show()
                    }

                }else {

                    val ownedCount = selectCategoryArray.count {
                        it.isOwned == 1 && !it.isWear
                    }

                    if (ownedCount > 0) {
                        CommonAlertDialog.Builder(this@ToryAvatarProfileFragment.requireContext())
                            .setMessage(R.string.avatar_select_category_change)
                            .setNegativeButton(R.string.system_alert_btn_cancel) {}
                            .setPositiveButton(R.string.system_alert_btn_ok) {
                                onBuy(false)
                            }
                            .show()
                    } else {
                        repository.myAvatarAttr!!.value?.apply {
                            if (selectCategoryArray[0].colorCode != hairColorCode || selectCategoryArray[1].colorCode != skinColorCode) {
                                CommonAlertDialog.Builder(this@ToryAvatarProfileFragment.requireContext())
                                    .setMessage(R.string.avatar_select_category_change)
                                    .setNegativeButton(R.string.system_alert_btn_cancel) {}
                                    .setPositiveButton(R.string.system_alert_btn_ok) {
                                        onBuy(false)
                                    }
                                    .show()
                            }
                        }
                    }
                }
            }

            R.id.buy_info_layout -> {
                Timber.tag(TAG).d("buy_info_layout")

                BuyItemsBottomDialogFragment(requireContext(), selectCategoryArray.toCollection(ArrayList())).apply {
                    setStyle(DialogFragment.STYLE_NORMAL, R.style.AppBottomSheetDialogTheme)

                    show(this@ToryAvatarProfileFragment.childFragmentManager, Constants.BuyItemsBottomDialogFragmentTag)
                }

            }
        }
    }

    /**
     * onAvatarReset
     */
    private fun onAvatarReset() = try {
        viewBinding.apply {

            initSetAvatar()

            //buyInfoLayout.visibility = View.GONE
            //buyButton.visibility = View.VISIBLE

            selectCategoryArray  = Array(5){ AvataModel() }

            avatarCategoryArrayList[selectCaegoryPosition].apply {
                isSelect = false
            }

            repository.myAvatarAttr.value!!.apply {
                selectCategoryArray[0].colorCode = hairColorCode
                selectCategoryArray[1].colorCode = skinColorCode

                val code = when(selectCategoryType) {
                    CategoryType.HAIR -> hairCode
                    CategoryType.FACE -> faceCode
                    CategoryType.TOP -> topCode
                    CategoryType.BOTTOM -> bottomCode
                    CategoryType.SHOES -> shoesCode
                }

                val index = avatarCategoryArrayList.indexOfFirst {
                    it.modelingCode == code
                }

                if(index >= 0) {
                    selectCategoryArray[selectCategoryType.ordinal].apply {
                        modelingCode = avatarCategoryArrayList[index].modelingCode
                        isOwned      = avatarCategoryArrayList[index].isOwned
                        isWear       = true
                    }

                    avatarCategoryArrayList[index].apply {
                        isSelect = true
                        isDefaultSelect = true
                    }
                    selectCaegoryPosition = index
                }
            }

            mAdapter.notifyDataSetChanged()

            avatarColorArrayList[selectColorPosition].apply {
                isSelect = false
            }

            val item = selectCategoryArray[selectCategoryType.ordinal]
            val index = avatarColorArrayList.indexOfFirst { it.colorCode == item.colorCode }
            if(index >= 0) {
                val selectColor = avatarColorArrayList[index]
                selectColor.isSelect = true
                avatarColorArrayList[index] = selectColor
                selectColorPosition = index
            }

            mColorSelectAdapter.notifyDataSetChanged()

        }
    }catch (e : Exception){
        Timber.tag(TAG).d(e.message)
    }


    /**
     * onBuy
     */
    private fun onBuy(isBuy : Boolean) = try {
        viewBinding.apply {
            colorSelect.visibility = View.VISIBLE
            colorSelectLayout.visibility = View.GONE

            val avatarAttr = repository.myAvatarAttr.value!!

            repository.apply {
                selectCategoryArray.forEachIndexed { index, it ->

                    when (index) {
                        0 -> {
                           if(it.id != -1) {
                               avatarAttr.apply {
                                   hairCode = it.modelingCode
                                   hairColorCode = it.colorCode
                               }
                               it.isWear = true
                           }else {
                               if(avatarAttr.hairColorCode != it.colorCode) {
                                   avatarAttr.hairColorCode = it.colorCode
                               }
                           }
                        }

                        1 -> {
                            if(it.id != -1) {
                                avatarAttr.apply {
                                    faceCode = it.modelingCode
                                    skinColorCode = it.colorCode
                                }
                                it.isWear = true
                            }else {
                                if(avatarAttr.skinColorCode != it.colorCode) {
                                    avatarAttr.skinColorCode = it.colorCode
                                }
                            }
                        }

                        2 -> {
                            if(it.id != -1) {
                                avatarAttr.topCode = it.modelingCode
                                it.isWear = true
                            }
                        }

                        3 -> {
                            if(it.id != -1) {
                                avatarAttr.bottomCode = it.modelingCode
                                it.isWear = true
                            }
                        }

                        4 -> {
                            if(it.id != -1) {
                                avatarAttr.shoesCode = it.modelingCode
                                it.isWear = true
                            }
                        }
                    }
                }

                val jsonValue = AvatarBuyItem(
                    skinColorCode   = avatarAttr.skinColorCode,
                    faceCode        = avatarAttr.faceCode,
                    hairCode        = avatarAttr.hairCode,
                    hairColorCode   = avatarAttr.hairColorCode,
                    topCode         = avatarAttr.topCode,
                    bottomCode      = avatarAttr.bottomCode,
                    shoesCode       = avatarAttr.shoesCode
                )

                val params = BaseParam(jsonValue).parameter
                Timber.d("onBuy $jsonValue")

                viewModel.avatarSave(params).subscribeBy(onNext = {

                    if(it.result!!.isSucceed) {
                        //val message = if(isBuy) R.string.category_buy_success else R.string.category_chage_save_success
                        repository.hasAvatarAttrYn = Constants.YesValue

                        val message = R.string.category_chage_save_success
                        CommonAlertDialog.Builder(requireContext())
                            .setMessage(message)
                            .setPositiveButton(R.string.system_alert_btn_ok) {
                                goToMain()
                            }
                            .show()

                    }else {
                        CommonAlertDialog.Builder(requireContext())
                            .setMessage(it.resultMessage.toString())
                            .setPositiveButton(R.string.system_alert_btn_ok) {}
                            .show()
                    }

                }, onError = {})

            }
        }
    }catch (e : Exception){
        Timber.d(e.message)
    }


    inner class RecyclerViewAdapter : RecyclerView.Adapter<RecyclerViewAdapter.RecycleViewHolder>() {
        override fun getItemCount(): Int = avatarCategoryArrayList.size

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecyclerViewAdapter.RecycleViewHolder {
            val binding = AvatarListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            return RecycleViewHolder(binding)
        }

        override fun onBindViewHolder(holder: RecyclerViewAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
            try {
                val item = avatarCategoryArrayList!![position]
                holder.run {
                    bind(item)

                    itemView.setOnClickListener {

                        if(item.isDefaultSelect && item.isSelect) {
                            return@setOnClickListener
                        }

                        val prevPosition = selectCaegoryPosition
                        item.isSelect = !item.isSelect
                        selectCaegoryPosition = position
                        notifyItemChanged(selectCaegoryPosition)

                        selectAvatar(item, position)

                        if (prevPosition != -1 && selectCaegoryPosition != prevPosition) {
                            val itemInfo = avatarCategoryArrayList!![prevPosition]
                            itemInfo.isSelect = false
                            notifyItemChanged(prevPosition)
                        }
                    }
                }
            }catch (e : Exception){
                Timber.d(e.message)
            }
        }

        inner class RecycleViewHolder(private var viewBinding: AvatarListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
            fun bind(item: AvatarModelingDTO) {
                with(viewBinding) {
                    item.run {

                        val imageResouce = if (item.isSelect) R.drawable.avatar_select_background
                                            else R.drawable.avatar_background

                        avatarLayout.setBackgroundResource(imageResouce)

                        txtPrice.text = String.format("%d", price)
                        Glide.with(root)
                            .load(imgUrl)
                            .centerCrop()
                            .into(viewBinding.avatar)

                        if(item.isOwned == 0) {
                            priceimage.visibility = View.VISIBLE
                            imgSelect.visibility = View.INVISIBLE
                        }else {
                            priceimage.visibility = View.INVISIBLE
                            imgSelect.visibility = View.VISIBLE
                        }
                    }
                }
            }
        }
    }



    private fun selectAvatar(item: AvatarModelingDTO, position: Int)  {
        Timber.d("selectAvatar")
        try {
            repository.apply {

                if (!item.isSelect) {
                    selectCategoryArray[selectCategoryType.ordinal] = AvataModel()

                    myAvatarAttr.value!!.apply {
                        var colorValue = ""

                        val codeValue = when (selectCategoryType) {
                            CategoryType.FACE -> faceCode
                            CategoryType.HAIR -> {
                                selectCategoryArray[selectCategoryType.ordinal].colorCode = hairColorCode
                                colorValue = hairColorCode
                                hairCode
                            }
                            CategoryType.TOP -> topCode
                            CategoryType.BOTTOM -> bottomCode
                            CategoryType.SHOES -> shoesCode
                        }

                        onCharacterSet(codeValue, colorValue)

                        val index = avatarCategoryArrayList.indexOfFirst {
                            it.modelingCode == codeValue
                        }

                        Timber.d("selectAvatar index - $index" )

                        if(index >= 0) {
                            avatarCategoryArrayList[index].apply {
                                isSelect = true
                                isDefaultSelect = true
                            }
                            selectCaegoryPosition = index
                        }

                        mAdapter.notifyDataSetChanged()
                    }

                    var price = 0
                    selectCategoryArray.forEach {
                        if(it.isOwned == 0) {
                            price += it.price
                        }
                    }

                    /*
                    val count = selectCategoryArray.count {
                        it.modelingCode != "" && it.isOwned == 0
                    }

                    viewBinding.apply {
                        if(count == 0 ) {
                            buyInfoLayout.visibility = View.GONE
                            buyButton.visibility = View.VISIBLE
                        }else {
                            buyInfoLayout.visibility = View.VISIBLE
                            buyButton.visibility = View.GONE
                        }

                        viewBinding.apply {
                            txtPurchase.text = String.format("%s", DecimalFormat("#,###").format(price))
                            txtPurchaseCount.text = String.format("(%d)", count)
                        }
                    }
                    */
                    return
                }

                selectCategoryArray[selectCategoryType.ordinal].apply {
                    id = item.id
                    modelingCode = item.modelingCode
                    imgUrl      = item.imgUrl
                    group       = item.group
                    isOwned     = item.isOwned
                    price       = item.price
                    pointCd     = item.pointCd

                    isSelect    = true

                    repository.myAvatarAttr.value!!.apply {
                        isWear = when(selectCategoryType) {
                            CategoryType.FACE -> faceCode == item.modelingCode
                            CategoryType.HAIR -> hairCode == item.modelingCode
                            CategoryType.TOP -> topCode == item.modelingCode
                            CategoryType.BOTTOM -> bottomCode == item.modelingCode
                            CategoryType.SHOES -> shoesCode == item.modelingCode
                        }
                    }

                    Timber.d("selectAvatar $isWear")

                    if(selectCategoryType == CategoryType.HAIR && colorCode.isEmpty()) {
                        colorCode = repository.myAvatarAttr.value!!.hairColorCode
                    }

                    onCharacterSet(item.modelingCode, colorCode)
                }

                var price = 0
                selectCategoryArray.forEach {
                    if(it.isOwned == 0) {
                        price += it.price
                    }
                }

                /*
                val count = selectCategoryArray.count {
                    it.modelingCode != "" && it.isOwned == 0
                }

                viewBinding.apply {
                    if(count == 0 ) {
                        buyInfoLayout.visibility = View.GONE
                        buyButton.visibility = View.VISIBLE
                    }else {
                        buyInfoLayout.visibility = View.VISIBLE
                        buyButton.visibility = View.GONE
                    }

                    viewBinding.apply {
                        txtPurchase.text = String.format("%s", DecimalFormat("#,###").format(price))
                        txtPurchaseCount.text = String.format("(%d)", count)
                    }
                }
                 */
            }

        }catch (e : Exception) {
            Timber.tag(TAG).d(e.message)
        }
    }


    private fun onCategorySort(sort: AvatarCategorySortyType) = try {
        when(sort) {
            AvatarCategorySortyType.SORT_BASIC -> {
                avatarCategoryArrayList.sortWith(
                    compareBy {
                        it.id
                    }
                )
            }

            AvatarCategorySortyType.SORT_POPULARITY ->{
                avatarCategoryArrayList.sortWith(
                    compareBy<AvatarModelingDTO> {
                        it.payCount
                    }.reversed()
                )
            }

            AvatarCategorySortyType.SORT_HIGHERPRICE -> {
                avatarCategoryArrayList.sortWith(
                    compareBy<AvatarModelingDTO> {
                        it.price
                    }.reversed()
                )
            }

            AvatarCategorySortyType.SORT_LOWESTPRICE -> {
                avatarCategoryArrayList.sortWith(
                    compareBy<AvatarModelingDTO> {
                        it.price
                    }
                )
            }

            else -> {}
        }

        mSortType = sort

        val item = selectCategoryArray[selectCategoryType.ordinal]
        val index = avatarCategoryArrayList.indexOfFirst { it.id == item.id }
        if(index >= 0) {
            val mySelectCategory = avatarCategoryArrayList[index]
            mySelectCategory.isSelect = true
            avatarCategoryArrayList[index] = mySelectCategory
            selectCaegoryPosition = index

        }else {
            repository.myAvatarAttr.value!!.apply {
                val code = when(selectCategoryType) {
                    CategoryType.HAIR -> hairCode
                    CategoryType.FACE -> faceCode
                    CategoryType.TOP -> topCode
                    CategoryType.BOTTOM -> bottomCode
                    CategoryType.SHOES -> shoesCode
                }

                val index = avatarCategoryArrayList.indexOfFirst {
                    it.modelingCode == code
                }

                if(index >= 0) {
                    selectCategoryArray[selectCategoryType.ordinal].apply {
                        modelingCode = avatarCategoryArrayList[index].modelingCode
                        isOwned      = avatarCategoryArrayList[index].isOwned
                        isWear       = true
                    }

                    avatarCategoryArrayList[index].apply {
                        isSelect = true
                        isDefaultSelect = true
                    }
                    selectCaegoryPosition = index
                }
            }
        }

        mAdapter.notifyDataSetChanged()

    }catch (e : Exception){
        Timber.d(e.message)
    }


    /****************************************************************************************************************/
    inner class ColorSelectAdapter : RecyclerView.Adapter<ColorSelectAdapter.RecycleViewHolder>() {
        override fun getItemCount(): Int = avatarColorArrayList.size

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ColorSelectAdapter.RecycleViewHolder {
            val binding = ColorListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            return RecycleViewHolder(binding)
        }

        override fun onBindViewHolder(holder: ColorSelectAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
            try {
                val itemValue = avatarColorArrayList!![position]
                holder.run {
                    bind(itemValue)

                    itemView.setOnClickListener {
                        val prevPosition = selectColorPosition
                        itemValue.isSelect = !itemValue.isSelect
                        selectColorPosition = position
                        notifyItemChanged(selectColorPosition)

                        selectColor(itemValue)

                        if (prevPosition != -1 && selectColorPosition != prevPosition) {
                            val itemInfo = avatarColorArrayList!![prevPosition]
                            itemInfo.isSelect = false
                            notifyItemChanged(prevPosition)
                        }
                    }
                }

            }catch (e : Exception){
                Timber.d(e.message)
            }
        }

        inner class RecycleViewHolder(private var viewBinding: ColorListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
            fun bind(item: AvatarColorDTO) {
                with(viewBinding) {
                    item.run {
                        val imageResouce = if (item.isSelect) R.drawable.select_round_stroke_purple
                                                    else R.drawable.unselect_round_stroke_white

                        colorLayout.setBackgroundResource(imageResouce)

                        imgColor.setBackgroundColor(Color.parseColor(item.colorCode))
                    }
                }
            }
        }
    }

    private fun selectColor(item: AvatarColorDTO) {
        try {
            repository.apply {

                if (!item.isSelect) {

                    val selectValue = selectCategoryArray[selectCategoryType.ordinal]

                    myAvatarAttr.value!!.apply {
                        val colorValue = when (selectCategoryType) {
                            CategoryType.FACE -> skinColorCode
                            CategoryType.HAIR -> hairColorCode
                            else -> faceColorCode
                        }
                        onCharacterSet(selectValue.modelingCode, colorValue)
                    }
                    return
                }

                val selectValue = selectCategoryArray[selectCategoryType.ordinal].apply {
                    colorCode = item.colorCode
                }

                when(selectCategoryType) {
                    CategoryType.FACE -> onCharacterSet(repository.myAvatarAttr.value!!.skinCode, selectValue.colorCode)
                    CategoryType.HAIR -> onCharacterSet(selectValue.modelingCode, selectValue.colorCode)
                    else -> {}
                }
            }

        } catch (e: Exception) {
            Timber.d(e.message)
        }
    }


    /**
     * onDefaultSave
     */
    private fun onDefaultSave() = try {

        repository.apply {
            val avatarAttr = myAvatarAttr.value!!

            val jsonValue = AvatarBuyItem(
                skinColorCode = avatarAttr.skinColorCode,
                faceCode = avatarAttr.faceCode,
                hairCode = avatarAttr.hairCode,
                hairColorCode = avatarAttr.hairColorCode,
                topCode = avatarAttr.topCode,
                bottomCode = avatarAttr.bottomCode,
                shoesCode = avatarAttr.shoesCode
            )

            val params = BaseParam(jsonValue).parameter
            Timber.d("onBuy $jsonValue")

            viewModel.avatarSave(params).subscribeBy(onNext = {

                if (it.result!!.isSucceed) {
                    repository.hasAvatarAttrYn = Constants.YesValue

                    val message = R.string.category_chage_save_success
                    CommonAlertDialog.Builder(requireContext())
                        .setMessage(message)
                        .setPositiveButton(R.string.system_alert_btn_ok) {
                            goToMain()
                        }
                        .show()

                } else {
                    CommonAlertDialog.Builder(requireContext())
                        .setMessage(it.resultMessage.toString())
                        .setPositiveButton(R.string.system_alert_btn_ok) {}
                        .show()
                }

            }, onError = {})
        }
    }catch (e : Exception){
        Timber.d(e.message)
    }


    private fun goToMain() = try {
        val values =  SwitchSceneSimple(scene = ToryMetaSceneParam.AvatarView)
        sendNativeUnityMessage(type = ToryMetaMessageType.SwitchSceneSimple,
            valueParam = values)

        CoroutineScope(Dispatchers.Main).launch {
            findNavController().popBackStack()
        }

    }catch (e : Exception){
        Timber.d(e.message)
    }
}
