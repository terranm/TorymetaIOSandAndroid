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
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.tnmeta.torymeta.R;
import java.lang.NullPointerException;
import java.lang.Override;
import java.lang.String;

public final class FragmentMyOpenedBinding implements ViewBinding {
  @NonNull
  private final ConstraintLayout rootView;

  @NonNull
  public final FloatingActionButton actionUpMove;

  @NonNull
  public final AppCompatTextView emptyView;

  @NonNull
  public final AppCompatTextView myOpenCount;

  @NonNull
  public final RecyclerView seminarListView;

  private FragmentMyOpenedBinding(@NonNull ConstraintLayout rootView,
      @NonNull FloatingActionButton actionUpMove, @NonNull AppCompatTextView emptyView,
      @NonNull AppCompatTextView myOpenCount, @NonNull RecyclerView seminarListView) {
    this.rootView = rootView;
    this.actionUpMove = actionUpMove;
    this.emptyView = emptyView;
    this.myOpenCount = myOpenCount;
    this.seminarListView = seminarListView;
  }

  @Override
  @NonNull
  public ConstraintLayout getRoot() {
    return rootView;
  }

  @NonNull
  public static FragmentMyOpenedBinding inflate(@NonNull LayoutInflater inflater) {
    return inflate(inflater, null, false);
  }

  @NonNull
  public static FragmentMyOpenedBinding inflate(@NonNull LayoutInflater inflater,
      @Nullable ViewGroup parent, boolean attachToParent) {
    View root = inflater.inflate(R.layout.fragment_my_opened, parent, false);
    if (attachToParent) {
      parent.addView(root);
    }
    return bind(root);
  }

  @NonNull
  public static FragmentMyOpenedBinding bind(@NonNull View rootView) {
    // The body of this method is generated in a way you would not otherwise write.
    // This is done to optimize the compiled bytecode for size and performance.
    int id;
    missingId: {
      id = R.id.actionUpMove;
      FloatingActionButton actionUpMove = ViewBindings.findChildViewById(rootView, id);
      if (actionUpMove == null) {
        break missingId;
      }

      id = R.id.emptyView;
      AppCompatTextView emptyView = ViewBindings.findChildViewById(rootView, id);
      if (emptyView == null) {
        break missingId;
      }

      id = R.id.my_open_count;
      AppCompatTextView myOpenCount = ViewBindings.findChildViewById(rootView, id);
      if (myOpenCount == null) {
        break missingId;
      }

      id = R.id.seminarListView;
      RecyclerView seminarListView = ViewBindings.findChildViewById(rootView, id);
      if (seminarListView == null) {
        break missingId;
      }

      return new FragmentMyOpenedBinding((ConstraintLayout) rootView, actionUpMove, emptyView,
          myOpenCount, seminarListView);
    }
    String missingId = rootView.getResources().getResourceName(id);
    throw new NullPointerException("Missing required view with ID: ".concat(missingId));
  }
}
