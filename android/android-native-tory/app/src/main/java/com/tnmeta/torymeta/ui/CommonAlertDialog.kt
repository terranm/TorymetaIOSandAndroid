package com.tnmeta.torymeta.ui


import android.app.AlertDialog
import android.content.Context
import android.graphics.Color
import android.view.LayoutInflater
import androidx.constraintlayout.widget.ConstraintLayout
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.databinding.CommonAlertDialogBinding
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.isVisible
import com.tnmeta.torymeta.utils.extensions.ViewExtensions.setVisible


/**
 * 공통 알림창. android.app.AlertDialog를 래핑한 형태입니다
 * LAYOUT_ID에 지정된 View가 설정됩니다
 */
object CommonAlertDialog {
    private const val THEME_ID = R.style.AppTheme_Dialog

    class Builder(val context: Context) {

        private val viewBinding = CommonAlertDialogBinding.inflate(LayoutInflater.from(context))

        private var builder: AlertDialog.Builder = AlertDialog.Builder(context, THEME_ID).apply {

            viewBinding.apply {

                arrayOf(title, message, negativeBtn, positiveBtn).forEach {
                    it.text = ""
                }

                setCancelable(false)
                setView(root)
            }
        }
        private var dialog: AlertDialog? = null

        init {
        }

        fun setCancelable(cancelable: Boolean): Builder {
            builder.setCancelable(cancelable)
            return this
        }

        fun setTitle(title: String): Builder {
            viewBinding.title.text = title
            return this
        }
        fun setTitle(titleResId: Int): Builder = setTitle(context.getString(titleResId))

        fun setMessage(message: String): Builder {
            viewBinding.message.text = message
            return this
        }
        fun setMessage(messageResId: Int): Builder = setMessage(context.getString(messageResId))

        private fun setNegativeButton(title: String = context.getString(R.string.system_alert_btn_cancel), onClick: () -> Unit): Builder {
            viewBinding.apply {
                negativeBtn.text = title
                negativeBtn.setOnClickListener {
                    onClick()
                    dialog?.dismiss()
                }
            }

            return this
        }

        fun setNegative(title: String , onClick: () -> Unit): Builder {
            viewBinding.apply {
                negativeBtn.text = title
                negativeBtn.setOnClickListener {
                    onClick()
                    dialog?.dismiss()
                }
            }
            return this
        }

        fun setNegative(title: String, color : String, onClick: () -> Unit): Builder {
            viewBinding.apply {
                negativeBtn.text = title
                negativeBtn.setTextColor(Color.parseColor(color))
                negativeBtn.setOnClickListener {
                    onClick()
                    dialog?.dismiss()
                }
            }
            return this
        }



        fun setNegativeButton(titleResId: Int, onClick: () -> Unit): Builder = setNegativeButton(context.getString(titleResId), onClick)

        fun setPositiveButton(title: String = context.getString(R.string.system_alert_btn_ok), onClick: () -> Unit): Builder {
            viewBinding.apply {
                positiveBtn.text = title
                positiveBtn.setOnClickListener {
                    onClick()
                    dialog?.dismiss()
                }
            }

            return this
        }


        fun setPositive(title: String , onClick: () -> Unit): Builder {
            viewBinding.apply {
                positiveBtn.text = title
                positiveBtn.setOnClickListener {
                    onClick()
                    dialog?.dismiss()
                }
            }
            return this
        }


        fun setPositive(title: String, color : String, onClick: () -> Unit): Builder {
            viewBinding.apply {
                positiveBtn.text = title
                positiveBtn.setTextColor(Color.parseColor(color))
                positiveBtn.setOnClickListener {
                    onClick()
                    dialog?.dismiss()
                }
            }

            return this
        }


        fun setPositiveButton(titleResId: Int, onClick: () -> Unit): Builder = setPositiveButton(context.getString(titleResId), onClick)

        fun show() {
            // update title and message
            arrayOf(viewBinding.title, viewBinding.message).forEach {
                it.setVisible(it.text.isNotEmpty())
            }

            viewBinding.apply {
                divider.apply {
                    setVisible(viewBinding.negativeBtn.text.isNotEmpty() && viewBinding.positiveBtn.text.isNotEmpty())
                }

                positiveBtn.apply {
                    val lp = layoutParams as ConstraintLayout.LayoutParams

                    if( viewBinding.divider.isVisible() ) {
                        lp.leftToRight = viewBinding.divider.id
                    } else {
                        lp.leftToLeft = viewBinding.btnLayout.id
                    }
                }

                negativeBtn.apply {
                    val lp = layoutParams as ConstraintLayout.LayoutParams

                    if( viewBinding.divider.isVisible() ) {
                        lp.rightToLeft = viewBinding.divider.id
                    } else {
                        lp.rightToRight = viewBinding.btnLayout.id
                    }
                }
            }

            dialog = builder.show()
        }
    }
}
