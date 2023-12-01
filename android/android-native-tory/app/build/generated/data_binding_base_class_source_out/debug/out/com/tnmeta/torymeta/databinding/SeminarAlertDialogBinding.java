// Generated by view binder compiler. Do not edit!
package com.tnmeta.torymeta.databinding;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.widget.AppCompatTextView;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.viewbinding.ViewBinding;
import androidx.viewbinding.ViewBindings;
import com.tnmeta.torymeta.R;
import java.lang.NullPointerException;
import java.lang.Override;
import java.lang.String;

public final class SeminarAlertDialogBinding implements ViewBinding {
  @NonNull
  private final ConstraintLayout rootView;

  @NonNull
  public final ConstraintLayout btnLayout;

  @NonNull
  public final AppCompatTextView divider;

  @NonNull
  public final AppCompatTextView message;

  @NonNull
  public final AppCompatTextView negativeBtn;

  @NonNull
  public final AppCompatTextView positiveBtn;

  @NonNull
  public final AppCompatTextView title;

  private SeminarAlertDialogBinding(@NonNull ConstraintLayout rootView,
      @NonNull ConstraintLayout btnLayout, @NonNull AppCompatTextView divider,
      @NonNull AppCompatTextView message, @NonNull AppCompatTextView negativeBtn,
      @NonNull AppCompatTextView positiveBtn, @NonNull AppCompatTextView title) {
    this.rootView = rootView;
    this.btnLayout = btnLayout;
    this.divider = divider;
    this.message = message;
    this.negativeBtn = negativeBtn;
    this.positiveBtn = positiveBtn;
    this.title = title;
  }

  @Override
  @NonNull
  public ConstraintLayout getRoot() {
    return rootView;
  }

  @NonNull
  public static SeminarAlertDialogBinding inflate(@NonNull LayoutInflater inflater) {
    return inflate(inflater, null, false);
  }

  @NonNull
  public static SeminarAlertDialogBinding inflate(@NonNull LayoutInflater inflater,
      @Nullable ViewGroup parent, boolean attachToParent) {
    View root = inflater.inflate(R.layout.seminar_alert_dialog, parent, false);
    if (attachToParent) {
      parent.addView(root);
    }
    return bind(root);
  }

  @NonNull
  public static SeminarAlertDialogBinding bind(@NonNull View rootView) {
    // The body of this method is generated in a way you would not otherwise write.
    // This is done to optimize the compiled bytecode for size and performance.
    int id;
    missingId: {
      id = R.id.btnLayout;
      ConstraintLayout btnLayout = ViewBindings.findChildViewById(rootView, id);
      if (btnLayout == null) {
        break missingId;
      }

      id = R.id.divider;
      AppCompatTextView divider = ViewBindings.findChildViewById(rootView, id);
      if (divider == null) {
        break missingId;
      }

      id = R.id.message;
      AppCompatTextView message = ViewBindings.findChildViewById(rootView, id);
      if (message == null) {
        break missingId;
      }

      id = R.id.negativeBtn;
      AppCompatTextView negativeBtn = ViewBindings.findChildViewById(rootView, id);
      if (negativeBtn == null) {
        break missingId;
      }

      id = R.id.positiveBtn;
      AppCompatTextView positiveBtn = ViewBindings.findChildViewById(rootView, id);
      if (positiveBtn == null) {
        break missingId;
      }

      id = R.id.title;
      AppCompatTextView title = ViewBindings.findChildViewById(rootView, id);
      if (title == null) {
        break missingId;
      }

      return new SeminarAlertDialogBinding((ConstraintLayout) rootView, btnLayout, divider, message,
          negativeBtn, positiveBtn, title);
    }
    String missingId = rootView.getResources().getResourceName(id);
    throw new NullPointerException("Missing required view with ID: ".concat(missingId));
  }
}
