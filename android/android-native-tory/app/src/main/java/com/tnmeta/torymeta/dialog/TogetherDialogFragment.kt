package com.tnmeta.torymeta.dialog

import android.content.Context
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.WindowManager
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.lifecycle.LifecycleObserver
import com.bumptech.glide.Glide
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.ToryApplication
import com.tnmeta.torymeta.databinding.TogetherDialgoFragmentBinding
import com.tnmeta.torymeta.databinding.TutorialDialogFragmentBinding
import com.tnmeta.torymeta.utils.Utilts
import timber.log.Timber

class TogetherDialogFragment : DialogFragment(), LifecycleObserver, View.OnClickListener {

    var listener: CommonDialogInterface.OnClickListener? = null

    private lateinit var viewBinding : TogetherDialgoFragmentBinding
    var url : String = ""

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setStyle(STYLE_NO_TITLE, R.style.DialogTheme)
        isCancelable = false
    }


    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        viewBinding = TogetherDialgoFragmentBinding.inflate(inflater, container, false)
        return viewBinding.root
    }

    override fun onResume() {
        super.onResume()
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
        viewBinding.apply {
            close.setOnClickListener(this@TogetherDialogFragment)
            toryMarketLayout.setOnClickListener(this@TogetherDialogFragment)
            toryTogetherLayout.setOnClickListener(this@TogetherDialogFragment)
            toryTalkLayout.setOnClickListener(this@TogetherDialogFragment)
            toryHelpLayout.setOnClickListener(this@TogetherDialogFragment)


            Timber.d("onViewCreated $url" )
            Glide.with(this@TogetherDialogFragment)
                .load(url)
                .into(imgLogo)
        }
    }

    override fun onClick(view: View) {
        when(view.id) {
            R.id.close -> {
                dismiss()
            }

            R.id.tory_market_layout,
            R.id.tory_together_layout,
            R.id.tory_talk_layout,
            R.id.tory_help_layout -> {
                listener!!.onClick(view.id)
                dismiss()
            }
        }
    }

    class TogetherDialogBuilder(var fragmentManager: FragmentManager?) {
        private var newFragment : TogetherDialogFragment? = null
        private var listener: CommonDialogInterface.OnClickListener? = null
        private var url : String = ""

        fun setClickListener(listener: CommonDialogInterface.OnClickListener) : TogetherDialogBuilder {
            this.listener = listener
            return this
        }

        fun setImageUrl(url : String) : TogetherDialogBuilder {
            this.url = url
            return this
        }

        fun show() {
            val transaction = fragmentManager!!.beginTransaction()
            val prev: Fragment? = fragmentManager!!.findFragmentByTag("TogetherDialogFragment")
            if (prev != null) {
                transaction.remove(prev)
            }
            transaction.addToBackStack(null)
            if (newFragment != null) newFragment!!.dismiss()

            newFragment = TogetherDialogFragment()

            this.run {
                newFragment!!.listener = listener
                newFragment!!.url = url
            }

            newFragment!!.show(transaction, "TogetherDialogFragment")
        }
    }

    fun with(fragmentManager: FragmentManager?): TogetherDialogBuilder? {
        return TogetherDialogBuilder(fragmentManager)
    }

}