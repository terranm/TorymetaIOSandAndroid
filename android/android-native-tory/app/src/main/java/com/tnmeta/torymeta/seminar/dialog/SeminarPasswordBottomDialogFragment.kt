package com.tnmeta.torymeta.seminar.dialog

import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.provider.Settings
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.DialogFragment
import androidx.recyclerview.widget.GridLayoutManager
import com.google.android.material.bottomsheet.BottomSheetBehavior
import com.google.android.material.bottomsheet.BottomSheetDialog
import com.google.android.material.bottomsheet.BottomSheetDialogFragment
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.databinding.SeminarPasswordBottomDialogFragmentBinding
import com.tnmeta.torymeta.ui.CommonAlertDialog

class SeminarPasswordBottomDialogFragment(context: Context, isVisible : Boolean = true) : BottomSheetDialogFragment(), View.OnClickListener {
    private val mContext: Context = context
    private val isVisible = isVisible
    private var viewBinding : SeminarPasswordBottomDialogFragmentBinding? = null

    lateinit var onClickListener: ((Any) -> Unit)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setStyle(DialogFragment.STYLE_NORMAL, R.style.AppBottomSheetDialogTheme)

    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        viewBinding = SeminarPasswordBottomDialogFragmentBinding.inflate(inflater, container, false)
        return viewBinding!!.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        (dialog as? BottomSheetDialog)?.behavior?.state = BottomSheetBehavior.STATE_EXPANDED

        dialog!!.window!!.attributes.windowAnimations = R.style.BottomSheetDialogAnimation
        viewBinding!!.apply {

            if(!isVisible) {
               txtPasswordConfirm.visibility = View.GONE
               editConfirmPassword.visibility = View.GONE
            }
            editPassword.addTextChangedListener(object : TextWatcher {
                override fun beforeTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {

                }

                override fun onTextChanged(text: CharSequence?, p1: Int, p2: Int, p3: Int) {
                    editBoxDeleteBtn.visibility = if(editPassword.text.toString().isEmpty()) View.GONE
                                                    else View.VISIBLE
                }

                override fun afterTextChanged(p0: Editable?) {
                }
            })

            editConfirmPassword.addTextChangedListener(object : TextWatcher {
                override fun beforeTextChanged(text: CharSequence?, p1: Int, p2: Int, p3: Int) {
                }

                override fun onTextChanged(p0: CharSequence?, p1: Int, p2: Int, p3: Int) {

                    editConfirmDeleteBtn.visibility = if (editConfirmPassword.text.toString().isEmpty()) View.GONE
                                                        else View.VISIBLE

                }

                override fun afterTextChanged(p0: Editable?) {

                }
            })

            apply.setOnClickListener(this@SeminarPasswordBottomDialogFragment)
            editBoxDeleteBtn.setOnClickListener(this@SeminarPasswordBottomDialogFragment)
            editConfirmDeleteBtn.setOnClickListener(this@SeminarPasswordBottomDialogFragment)
        }
    }

    override fun onDestroyView() {
        super.onDestroyView()
        viewBinding = null
    }

    override fun onClick(view: View) {

        when(view.id) {
            R.id.apply -> {
                viewBinding!!.apply {
                    if(isVisible) {
                        if (editPassword.text.toString() == editConfirmPassword.text.toString()) {
                            onClickListener(editPassword.text.toString())
                            dialog?.dismiss()
                        } else {
                            CommonAlertDialog.Builder(mContext)
                                .setCancelable(false)
                                .setMessage(R.string.input_password_error_message)
                                .setPositiveButton(R.string.system_alert_btn_ok) {}
                                .show()
                        }
                    }else {
                        if(editPassword.text.toString().isEmpty()) {
                            CommonAlertDialog.Builder(mContext)
                                .setCancelable(false)
                                .setMessage(R.string.password_input_hint)
                                .setPositiveButton(R.string.system_alert_btn_ok) {}
                                .show()
                            return@apply
                        }

                        onClickListener(editPassword.text.toString())
                        dialog?.dismiss()
                    }
                }
            }
            R.id.editBoxDeleteBtn -> {
                viewBinding!!.editPassword.setText("")
            }

            R.id.edit_confirm_deleteBtn -> {
                viewBinding!!.editConfirmPassword.setText("")
            }
        }
    }

}


