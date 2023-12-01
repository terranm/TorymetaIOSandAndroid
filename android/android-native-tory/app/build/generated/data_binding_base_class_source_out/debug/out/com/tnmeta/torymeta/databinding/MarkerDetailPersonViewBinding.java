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
import de.hdodenhof.circleimageview.CircleImageView;
import java.lang.NullPointerException;
import java.lang.Override;
import java.lang.String;

public final class MarkerDetailPersonViewBinding implements ViewBinding {
  @NonNull
  private final ConstraintLayout rootView;

  @NonNull
  public final AppCompatImageView line;

  @NonNull
  public final AppCompatImageView locationToggleBtn;

  @NonNull
  public final AppCompatImageView myIndicator;

  @NonNull
  public final AppCompatTextView nickname;

  @NonNull
  public final CircleImageView profileImg;

  private MarkerDetailPersonViewBinding(@NonNull ConstraintLayout rootView,
      @NonNull AppCompatImageView line, @NonNull AppCompatImageView locationToggleBtn,
      @NonNull AppCompatImageView myIndicator, @NonNull AppCompatTextView nickname,
      @NonNull CircleImageView profileImg) {
    this.rootView = rootView;
    this.line = line;
    this.locationToggleBtn = locationToggleBtn;
    this.myIndicator = myIndicator;
    this.nickname = nickname;
    this.profileImg = profileImg;
  }

  @Override
  @NonNull
  public ConstraintLayout getRoot() {
    return rootView;
  }

  @NonNull
  public static MarkerDetailPersonViewBinding inflate(@NonNull LayoutInflater inflater) {
    return inflate(inflater, null, false);
  }

  @NonNull
  public static MarkerDetailPersonViewBinding inflate(@NonNull LayoutInflater inflater,
      @Nullable ViewGroup parent, boolean attachToParent) {
    View root = inflater.inflate(R.layout.marker_detail_person_view, parent, false);
    if (attachToParent) {
      parent.addView(root);
    }
    return bind(root);
  }

  @NonNull
  public static MarkerDetailPersonViewBinding bind(@NonNull View rootView) {
    // The body of this method is generated in a way you would not otherwise write.
    // This is done to optimize the compiled bytecode for size and performance.
    int id;
    missingId: {
      id = R.id.line;
      AppCompatImageView line = ViewBindings.findChildViewById(rootView, id);
      if (line == null) {
        break missingId;
      }

      id = R.id.locationToggleBtn;
      AppCompatImageView locationToggleBtn = ViewBindings.findChildViewById(rootView, id);
      if (locationToggleBtn == null) {
        break missingId;
      }

      id = R.id.myIndicator;
      AppCompatImageView myIndicator = ViewBindings.findChildViewById(rootView, id);
      if (myIndicator == null) {
        break missingId;
      }

      id = R.id.nickname;
      AppCompatTextView nickname = ViewBindings.findChildViewById(rootView, id);
      if (nickname == null) {
        break missingId;
      }

      id = R.id.profileImg;
      CircleImageView profileImg = ViewBindings.findChildViewById(rootView, id);
      if (profileImg == null) {
        break missingId;
      }

      return new MarkerDetailPersonViewBinding((ConstraintLayout) rootView, line, locationToggleBtn,
          myIndicator, nickname, profileImg);
    }
    String missingId = rootView.getResources().getResourceName(id);
    throw new NullPointerException("Missing required view with ID: ".concat(missingId));
  }
}