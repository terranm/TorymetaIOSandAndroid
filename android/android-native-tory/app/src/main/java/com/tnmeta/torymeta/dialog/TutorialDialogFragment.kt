package com.tnmeta.torymeta.dialog

import android.content.Context
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.WindowManager
import androidx.core.content.ContextCompat
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.lifecycle.LifecycleObserver
import com.bumptech.glide.Glide
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.databinding.TutorialDialogFragmentBinding
import com.tnmeta.torymeta.utils.Utilts
import timber.log.Timber


class TutorialDialogFragment : DialogFragment(), LifecycleObserver, View.OnClickListener {

    var listener: CommonDialogInterface.OnClickListener? = null
    var resourceID : Int = R.drawable.mypage_tutorial

    private lateinit var viewBinding : TutorialDialogFragmentBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setStyle(STYLE_NO_TITLE, R.style.DialogTheme)
        isCancelable = false
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        viewBinding = TutorialDialogFragmentBinding.inflate(inflater, container, false)

        return viewBinding.root
    }



    override fun onResume() {
        super.onResume()
        try {
            dialog?.window?.apply {
                setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)
                setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT))
                clearFlags(WindowManager.LayoutParams.FLAG_DIM_BEHIND)
            }

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    override fun onStart() {
        super.onStart()

    }


    fun onActivityCreated() {
        activity?.lifecycle?.removeObserver(this)
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)
        activity?.lifecycle?.addObserver(this)
    }


    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        val screenSize = Utilts.instance.getScreenSize(ToryApplication.activity!!)
        val width = screenSize.x.toFloat()
        val height = screenSize.y.toFloat()

        viewBinding.apply {
            tutorialImage.setImageResource(resourceID)
            close.setOnClickListener(this@TutorialDialogFragment)
        }
    }

    override fun onClick(view: View) {
        when(view.id) {
            R.id.close -> {
                dismiss()
                listener!!.onClick(R.id.close)
            }
        }
    }

    class TutorialDialogBuilder(var fragmentManager: FragmentManager?) {
        private var newFragment : TutorialDialogFragment? = null
        private var listener: CommonDialogInterface.OnClickListener? = null
        private var resourceID : Int = R.drawable.mypage_tutorial

        fun setClickListener(listener: CommonDialogInterface.OnClickListener) : TutorialDialogBuilder {
            this.listener = listener
            return this
        }

        fun setBackgroundResource(resourceID : Int) : TutorialDialogBuilder {
            this.resourceID = resourceID
            return this
        }

        fun show() {
            val transaction = fragmentManager!!.beginTransaction()
            val prev: Fragment? = fragmentManager!!.findFragmentByTag("TutorialDialogFragment")
            if (prev != null) {
                transaction.remove(prev)
            }
            transaction.addToBackStack(null)
            if (newFragment != null) newFragment!!.dismiss()

            newFragment = TutorialDialogFragment()

            this.run {
                newFragment!!.listener = listener
                newFragment!!.resourceID = resourceID
            }

            newFragment!!.show(transaction, "TutorialDialogFragment")
        }
    }

    fun with(fragmentManager: FragmentManager?): TutorialDialogBuilder? {
        return TutorialDialogBuilder(fragmentManager)
    }

}


