// Generated by view binder compiler. Do not edit!
package com.tnmeta.torymeta.databinding;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.viewbinding.ViewBinding;
import androidx.viewbinding.ViewBindings;
import com.github.chrisbanes.photoview.PhotoView;
import com.tnmeta.torymeta.R;
import java.lang.NullPointerException;
import java.lang.Override;
import java.lang.String;

public final class ActivitySeminarRoomViewBinding implements ViewBinding {
  @NonNull
  private final ConstraintLayout rootView;

  @NonNull
  public final ImageView close;

  @NonNull
  public final PhotoView imageSlider;

  @NonNull
  public final ConstraintLayout topLayout;

  private ActivitySeminarRoomViewBinding(@NonNull ConstraintLayout rootView,
      @NonNull ImageView close, @NonNull PhotoView imageSlider,
      @NonNull ConstraintLayout topLayout) {
    this.rootView = rootView;
    this.close = close;
    this.imageSlider = imageSlider;
    this.topLayout = topLayout;
  }

  @Override
  @NonNull
  public ConstraintLayout getRoot() {
    return rootView;
  }

  @NonNull
  public static ActivitySeminarRoomViewBinding inflate(@NonNull LayoutInflater inflater) {
    return inflate(inflater, null, false);
  }

  @NonNull
  public static ActivitySeminarRoomViewBinding inflate(@NonNull LayoutInflater inflater,
      @Nullable ViewGroup parent, boolean attachToParent) {
    View root = inflater.inflate(R.layout.activity_seminar_room_view, parent, false);
    if (attachToParent) {
      parent.addView(root);
    }
    return bind(root);
  }

  @NonNull
  public static ActivitySeminarRoomViewBinding bind(@NonNull View rootView) {
    // The body of this method is generated in a way you would not otherwise write.
    // This is done to optimize the compiled bytecode for size and performance.
    int id;
    missingId: {
      id = R.id.close;
      ImageView close = ViewBindings.findChildViewById(rootView, id);
      if (close == null) {
        break missingId;
      }

      id = R.id.imageSlider;
      PhotoView imageSlider = ViewBindings.findChildViewById(rootView, id);
      if (imageSlider == null) {
        break missingId;
      }

      id = R.id.topLayout;
      ConstraintLayout topLayout = ViewBindings.findChildViewById(rootView, id);
      if (topLayout == null) {
        break missingId;
      }

      return new ActivitySeminarRoomViewBinding((ConstraintLayout) rootView, close, imageSlider,
          topLayout);
    }
    String missingId = rootView.getResources().getResourceName(id);
    throw new NullPointerException("Missing required view with ID: ".concat(missingId));
  }
}
