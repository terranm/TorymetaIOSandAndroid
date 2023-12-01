// Generated by view binder compiler. Do not edit!
package com.tnmeta.torymeta.databinding;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.widget.AppCompatTextView;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.recyclerview.widget.RecyclerView;
import androidx.viewbinding.ViewBinding;
import androidx.viewbinding.ViewBindings;
import com.airbnb.lottie.LottieAnimationView;
import com.tnmeta.torymeta.R;
import java.lang.NullPointerException;
import java.lang.Override;
import java.lang.String;

public final class ActivityToryChargeFragmentBinding implements ViewBinding {
  @NonNull
  private final ConstraintLayout rootView;

  @NonNull
  public final LottieAnimationView animationView;

  @NonNull
  public final AppCompatTextView emptyView;

  @NonNull
  public final RecyclerView recyclerView;

  @NonNull
  public final RecyclerView topListView;

  private ActivityToryChargeFragmentBinding(@NonNull ConstraintLayout rootView,
      @NonNull LottieAnimationView animationView, @NonNull AppCompatTextView emptyView,
      @NonNull RecyclerView recyclerView, @NonNull RecyclerView topListView) {
    this.rootView = rootView;
    this.animationView = animationView;
    this.emptyView = emptyView;
    this.recyclerView = recyclerView;
    this.topListView = topListView;
  }

  @Override
  @NonNull
  public ConstraintLayout getRoot() {
    return rootView;
  }

  @NonNull
  public static ActivityToryChargeFragmentBinding inflate(@NonNull LayoutInflater inflater) {
    return inflate(inflater, null, false);
  }

  @NonNull
  public static ActivityToryChargeFragmentBinding inflate(@NonNull LayoutInflater inflater,
      @Nullable ViewGroup parent, boolean attachToParent) {
    View root = inflater.inflate(R.layout.activity_tory_charge_fragment, parent, false);
    if (attachToParent) {
      parent.addView(root);
    }
    return bind(root);
  }

  @NonNull
  public static ActivityToryChargeFragmentBinding bind(@NonNull View rootView) {
    // The body of this method is generated in a way you would not otherwise write.
    // This is done to optimize the compiled bytecode for size and performance.
    int id;
    missingId: {
      id = R.id.animationView;
      LottieAnimationView animationView = ViewBindings.findChildViewById(rootView, id);
      if (animationView == null) {
        break missingId;
      }

      id = R.id.emptyView;
      AppCompatTextView emptyView = ViewBindings.findChildViewById(rootView, id);
      if (emptyView == null) {
        break missingId;
      }

      id = R.id.recyclerView;
      RecyclerView recyclerView = ViewBindings.findChildViewById(rootView, id);
      if (recyclerView == null) {
        break missingId;
      }

      id = R.id.topListView;
      RecyclerView topListView = ViewBindings.findChildViewById(rootView, id);
      if (topListView == null) {
        break missingId;
      }

      return new ActivityToryChargeFragmentBinding((ConstraintLayout) rootView, animationView,
          emptyView, recyclerView, topListView);
    }
    String missingId = rootView.getResources().getResourceName(id);
    throw new NullPointerException("Missing required view with ID: ".concat(missingId));
  }
}
