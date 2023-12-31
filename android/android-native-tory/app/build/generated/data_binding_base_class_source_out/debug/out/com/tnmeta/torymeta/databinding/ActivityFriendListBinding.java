// Generated by view binder compiler. Do not edit!
package com.tnmeta.torymeta.databinding;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.recyclerview.widget.RecyclerView;
import androidx.viewbinding.ViewBinding;
import androidx.viewbinding.ViewBindings;
import com.tnmeta.torymeta.R;
import java.lang.NullPointerException;
import java.lang.Override;
import java.lang.String;

public final class ActivityFriendListBinding implements ViewBinding {
  @NonNull
  private final ConstraintLayout rootView;

  @NonNull
  public final RecyclerView listView;

  @NonNull
  public final ImageView searchBtn;

  @NonNull
  public final CommonTopBarBinding topBar;

  @NonNull
  public final ConstraintLayout topBarLayout;

  private ActivityFriendListBinding(@NonNull ConstraintLayout rootView,
      @NonNull RecyclerView listView, @NonNull ImageView searchBtn,
      @NonNull CommonTopBarBinding topBar, @NonNull ConstraintLayout topBarLayout) {
    this.rootView = rootView;
    this.listView = listView;
    this.searchBtn = searchBtn;
    this.topBar = topBar;
    this.topBarLayout = topBarLayout;
  }

  @Override
  @NonNull
  public ConstraintLayout getRoot() {
    return rootView;
  }

  @NonNull
  public static ActivityFriendListBinding inflate(@NonNull LayoutInflater inflater) {
    return inflate(inflater, null, false);
  }

  @NonNull
  public static ActivityFriendListBinding inflate(@NonNull LayoutInflater inflater,
      @Nullable ViewGroup parent, boolean attachToParent) {
    View root = inflater.inflate(R.layout.activity_friend_list, parent, false);
    if (attachToParent) {
      parent.addView(root);
    }
    return bind(root);
  }

  @NonNull
  public static ActivityFriendListBinding bind(@NonNull View rootView) {
    // The body of this method is generated in a way you would not otherwise write.
    // This is done to optimize the compiled bytecode for size and performance.
    int id;
    missingId: {
      id = R.id.listView;
      RecyclerView listView = ViewBindings.findChildViewById(rootView, id);
      if (listView == null) {
        break missingId;
      }

      id = R.id.searchBtn;
      ImageView searchBtn = ViewBindings.findChildViewById(rootView, id);
      if (searchBtn == null) {
        break missingId;
      }

      id = R.id.topBar;
      View topBar = ViewBindings.findChildViewById(rootView, id);
      if (topBar == null) {
        break missingId;
      }
      CommonTopBarBinding binding_topBar = CommonTopBarBinding.bind(topBar);

      id = R.id.topBar_Layout;
      ConstraintLayout topBarLayout = ViewBindings.findChildViewById(rootView, id);
      if (topBarLayout == null) {
        break missingId;
      }

      return new ActivityFriendListBinding((ConstraintLayout) rootView, listView, searchBtn,
          binding_topBar, topBarLayout);
    }
    String missingId = rootView.getResources().getResourceName(id);
    throw new NullPointerException("Missing required view with ID: ".concat(missingId));
  }
}
