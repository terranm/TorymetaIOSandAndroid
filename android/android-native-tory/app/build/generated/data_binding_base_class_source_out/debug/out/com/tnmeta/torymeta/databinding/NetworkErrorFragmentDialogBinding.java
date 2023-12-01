// Generated by view binder compiler. Do not edit!
package com.tnmeta.torymeta.databinding;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.widget.AppCompatTextView;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.constraintlayout.widget.Guideline;
import androidx.viewbinding.ViewBinding;
import androidx.viewbinding.ViewBindings;
import com.tnmeta.torymeta.R;
import java.lang.NullPointerException;
import java.lang.Override;
import java.lang.String;

public final class NetworkErrorFragmentDialogBinding implements ViewBinding {
  @NonNull
  private final ConstraintLayout rootView;

  @NonNull
  public final ImageView backBtn;

  @NonNull
  public final Guideline guideline;

  @NonNull
  public final AppCompatTextView networkComment01;

  @NonNull
  public final AppCompatTextView networkTitle;

  @NonNull
  public final Button refresh;

  @NonNull
  public final ConstraintLayout titleLayout;

  private NetworkErrorFragmentDialogBinding(@NonNull ConstraintLayout rootView,
      @NonNull ImageView backBtn, @NonNull Guideline guideline,
      @NonNull AppCompatTextView networkComment01, @NonNull AppCompatTextView networkTitle,
      @NonNull Button refresh, @NonNull ConstraintLayout titleLayout) {
    this.rootView = rootView;
    this.backBtn = backBtn;
    this.guideline = guideline;
    this.networkComment01 = networkComment01;
    this.networkTitle = networkTitle;
    this.refresh = refresh;
    this.titleLayout = titleLayout;
  }

  @Override
  @NonNull
  public ConstraintLayout getRoot() {
    return rootView;
  }

  @NonNull
  public static NetworkErrorFragmentDialogBinding inflate(@NonNull LayoutInflater inflater) {
    return inflate(inflater, null, false);
  }

  @NonNull
  public static NetworkErrorFragmentDialogBinding inflate(@NonNull LayoutInflater inflater,
      @Nullable ViewGroup parent, boolean attachToParent) {
    View root = inflater.inflate(R.layout.network_error_fragment_dialog, parent, false);
    if (attachToParent) {
      parent.addView(root);
    }
    return bind(root);
  }

  @NonNull
  public static NetworkErrorFragmentDialogBinding bind(@NonNull View rootView) {
    // The body of this method is generated in a way you would not otherwise write.
    // This is done to optimize the compiled bytecode for size and performance.
    int id;
    missingId: {
      id = R.id.backBtn;
      ImageView backBtn = ViewBindings.findChildViewById(rootView, id);
      if (backBtn == null) {
        break missingId;
      }

      id = R.id.guideline;
      Guideline guideline = ViewBindings.findChildViewById(rootView, id);
      if (guideline == null) {
        break missingId;
      }

      id = R.id.network_comment_01;
      AppCompatTextView networkComment01 = ViewBindings.findChildViewById(rootView, id);
      if (networkComment01 == null) {
        break missingId;
      }

      id = R.id.network_title;
      AppCompatTextView networkTitle = ViewBindings.findChildViewById(rootView, id);
      if (networkTitle == null) {
        break missingId;
      }

      id = R.id.refresh;
      Button refresh = ViewBindings.findChildViewById(rootView, id);
      if (refresh == null) {
        break missingId;
      }

      id = R.id.title_layout;
      ConstraintLayout titleLayout = ViewBindings.findChildViewById(rootView, id);
      if (titleLayout == null) {
        break missingId;
      }

      return new NetworkErrorFragmentDialogBinding((ConstraintLayout) rootView, backBtn, guideline,
          networkComment01, networkTitle, refresh, titleLayout);
    }
    String missingId = rootView.getResources().getResourceName(id);
    throw new NullPointerException("Missing required view with ID: ".concat(missingId));
  }
}
