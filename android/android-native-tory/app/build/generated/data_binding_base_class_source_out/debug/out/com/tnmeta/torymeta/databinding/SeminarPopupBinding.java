// Generated by view binder compiler. Do not edit!
package com.tnmeta.torymeta.databinding;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
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

public final class SeminarPopupBinding implements ViewBinding {
  @NonNull
  private final ConstraintLayout rootView;

  @NonNull
  public final ImageView closeBtn;

  @NonNull
  public final AppCompatTextView desc1;

  @NonNull
  public final AppCompatTextView desc2;

  @NonNull
  public final ConstraintLayout enterBtn;

  private SeminarPopupBinding(@NonNull ConstraintLayout rootView, @NonNull ImageView closeBtn,
      @NonNull AppCompatTextView desc1, @NonNull AppCompatTextView desc2,
      @NonNull ConstraintLayout enterBtn) {
    this.rootView = rootView;
    this.closeBtn = closeBtn;
    this.desc1 = desc1;
    this.desc2 = desc2;
    this.enterBtn = enterBtn;
  }

  @Override
  @NonNull
  public ConstraintLayout getRoot() {
    return rootView;
  }

  @NonNull
  public static SeminarPopupBinding inflate(@NonNull LayoutInflater inflater) {
    return inflate(inflater, null, false);
  }

  @NonNull
  public static SeminarPopupBinding inflate(@NonNull LayoutInflater inflater,
      @Nullable ViewGroup parent, boolean attachToParent) {
    View root = inflater.inflate(R.layout.seminar_popup, parent, false);
    if (attachToParent) {
      parent.addView(root);
    }
    return bind(root);
  }

  @NonNull
  public static SeminarPopupBinding bind(@NonNull View rootView) {
    // The body of this method is generated in a way you would not otherwise write.
    // This is done to optimize the compiled bytecode for size and performance.
    int id;
    missingId: {
      id = R.id.closeBtn;
      ImageView closeBtn = ViewBindings.findChildViewById(rootView, id);
      if (closeBtn == null) {
        break missingId;
      }

      id = R.id.desc1;
      AppCompatTextView desc1 = ViewBindings.findChildViewById(rootView, id);
      if (desc1 == null) {
        break missingId;
      }

      id = R.id.desc2;
      AppCompatTextView desc2 = ViewBindings.findChildViewById(rootView, id);
      if (desc2 == null) {
        break missingId;
      }

      id = R.id.enterBtn;
      ConstraintLayout enterBtn = ViewBindings.findChildViewById(rootView, id);
      if (enterBtn == null) {
        break missingId;
      }

      return new SeminarPopupBinding((ConstraintLayout) rootView, closeBtn, desc1, desc2, enterBtn);
    }
    String missingId = rootView.getResources().getResourceName(id);
    throw new NullPointerException("Missing required view with ID: ".concat(missingId));
  }
}
