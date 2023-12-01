package com.tnmeta.torymeta.dialog

import android.content.Context
import android.graphics.Color
import android.graphics.drawable.ColorDrawable
import android.os.Build
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.view.WindowManager
import android.widget.Toast
import androidx.core.content.ContextCompat
import androidx.core.view.WindowInsetsControllerCompat
import androidx.fragment.app.DialogFragment
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.lifecycle.LifecycleObserver
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.databinding.NetworkErrorFragmentDialogBinding
import com.tnmeta.torymeta.utils.Utilts
import timber.log.Timber

class NetworkErrorDialogFragment : DialogFragment(), LifecycleObserver, View.OnClickListener {

    private lateinit var viewBinding : NetworkErrorFragmentDialogBinding
    private var listener: CommonDialogInterface.OnClickListener? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setStyle(STYLE_NO_TITLE, R.style.NetworkErrorDialogTheme)
        isCancelable = false
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        viewBinding = NetworkErrorFragmentDialogBinding.inflate(inflater, container, false)
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

    override fun onAttach(context: Context) {
        super.onAttach(context)
        activity?.lifecycle?.addObserver(this)
    }


    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

        viewBinding.apply {
            backBtn.setOnClickListener(this@NetworkErrorDialogFragment)
            refresh.setOnClickListener(this@NetworkErrorDialogFragment)
        }
    }

    override fun onClick(view: View) {
        when(view.id) {
            R.id.backBtn -> {
                dismiss()
                listener!!.onClick(view.id)
            }

            R.id.refresh -> {
                if(Utilts.instance.netWorkCheck(requireContext())) {
                    dismiss()
                    listener!!.onClick(view.id)
                }else {
                    Toast.makeText(requireContext(), resources.getString(R.string.network_error_message), Toast.LENGTH_SHORT).show()
                }
            }
        }
    }

    class NetworkErrorDialogBuilder(var fragmentManager: FragmentManager?) {
        private var newFragment : NetworkErrorDialogFragment? = null
        private var listener: CommonDialogInterface.OnClickListener? = null

        fun setClickListener(listener: CommonDialogInterface.OnClickListener) : NetworkErrorDialogBuilder {
            this.listener = listener
            return this
        }

        fun show() {
            val transaction = fragmentManager!!.beginTransaction()
            val prev: Fragment? = fragmentManager!!.findFragmentByTag("NetworkErrorDialogFragment")
            if (prev != null) {
                transaction.remove(prev)
            }
            transaction.addToBackStack(null)
            if (newFragment != null) newFragment!!.dismiss()

            newFragment = NetworkErrorDialogFragment()

            this.run {
                newFragment!!.listener = listener
            }
            newFragment!!.show(transaction, "NetworkErrorDialogFragment")
        }
    }
}