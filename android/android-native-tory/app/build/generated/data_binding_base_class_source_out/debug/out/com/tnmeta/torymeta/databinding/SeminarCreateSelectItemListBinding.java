// Generated by view binder compiler. Do not edit!
package com.tnmeta.torymeta.databinding;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.widget.AppCompatImageView;
import androidx.appcompat.widget.AppCompatTextView;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.viewbinding.ViewBinding;
import androidx.viewbinding.ViewBindings;
import com.tnmeta.torymeta.R;
import java.lang.NullPointerException;
import java.lang.Override;
import java.lang.String;

public final class SeminarCreateSelectItemListBinding implements ViewBinding {
  @NonNull
  private final ConstraintLayout rootView;

  @NonNull
  public final AppCompatTextView seminarId;

  @NonNull
  public final AppCompatImageView seminarImage;

  private SeminarCreateSelectItemListBinding(@NonNull ConstraintLayout rootView,
      @NonNull AppCompatTextView seminarId, @NonNull AppCompatImageView seminarImage) {
    this.rootView = rootView;
    this.seminarId = seminarId;
    this.seminarImage = seminarImage;
  }

  @Override
  @NonNull
  public ConstraintLayout getRoot() {
    return rootView;
  }

  @NonNull
  public static SeminarCreateSelectItemListBinding inflate(@NonNull LayoutInflater inflater) {
    return inflate(inflater, null, false);
  }

  @NonNull
  public static SeminarCreateSelectItemListBinding inflate(@NonNull LayoutInflater inflater,
      @Nullable ViewGroup parent, boolean attachToParent) {
    View root = inflater.inflate(R.layout.seminar_create_select_item_list, parent, false);
    if (attachToParent) {
      parent.addView(root);
    }
    return bind(root);
  }

  @NonNull
  public static SeminarCreateSelectItemListBinding bind(@NonNull View rootView) {
    // The body of this method is generated in a way you would not otherwise write.
    // This is done to optimize the compiled bytecode for size and performance.
    int id;
    missingId: {
      id = R.id.seminar_id;
      AppCompatTextView seminarId = ViewBindings.findChildViewById(rootView, id);
      if (seminarId == null) {
        break missingId;
      }

      id = R.id.seminar_image;
      AppCompatImageView seminarImage = ViewBindings.findChildViewById(rootView, id);
      if (seminarImage == null) {
        break missingId;
      }

      return new SeminarCreateSelectItemListBinding((ConstraintLayout) rootView, seminarId,
          seminarImage);
    }
    String missingId = rootView.getResources().getResourceName(id);
    throw new NullPointerException("Missing required view with ID: ".concat(missingId));
  }
}
