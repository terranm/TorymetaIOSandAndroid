package com.tnmeta.torymeta.dialog

import android.content.Context
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.WindowManager
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.lifecycle.LifecycleObserver
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.databinding.TutorialDialogInfoFragmentBinding
import timber.log.Timber

class TutorialDialogInfoFragment : DialogFragment(), LifecycleObserver, View.OnClickListener {

    var listener: CommonDialogInterface.OnClickListener? = null
    private lateinit var binding : TutorialDialogInfoFragmentBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setStyle(STYLE_NO_TITLE, R.style.DialogTheme)
        isCancelable = false
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = TutorialDialogInfoFragmentBinding.inflate(inflater, container, false)
        return binding.root
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
    override fun onAttach(context: Context) {
        super.onAttach(context)
        activity?.lifecycle?.addObserver(this)
    }


    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        binding.apply {
            txtClose.setOnClickListener(this@TutorialDialogInfoFragment)
        }
    }

    override fun onClick(view: View) {
        when(view.id) {
            R.id.txtClose -> {
                listener!!.onClick(R.id.txtClose)
                dismiss()
            }
        }
    }

    class TutorialInfoDialogBuilder(var fragmentManager: FragmentManager?) {
        private var newFragment : TutorialDialogInfoFragment? = null
        private var listener: CommonDialogInterface.OnClickListener? = null

        fun setClickListener(listener: CommonDialogInterface.OnClickListener) : TutorialInfoDialogBuilder {
            this.listener = listener
            return this
        }

        fun show() {
            val transaction = fragmentManager!!.beginTransaction()
            val prev: Fragment? = fragmentManager!!.findFragmentByTag("TutorialInfoDialogFragment")
            if (prev != null) {
                transaction.remove(prev)
            }

            transaction.addToBackStack(null)
            if (newFragment != null) newFragment!!.dismiss()

            newFragment = TutorialDialogInfoFragment()

            this.run {
                newFragment!!.listener = listener
            }

            newFragment!!.show(transaction, "TutorialInfoDialogFragment")
        }
    }

    fun with(fragmentManager: FragmentManager?): TutorialInfoDialogBuilder? {
        return TutorialInfoDialogBuilder(fragmentManager)
    }

}