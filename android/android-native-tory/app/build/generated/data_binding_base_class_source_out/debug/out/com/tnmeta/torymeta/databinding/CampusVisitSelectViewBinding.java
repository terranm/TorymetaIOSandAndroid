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
import com.tnmeta.torymeta.R;
import java.lang.NullPointerException;
import java.lang.Override;
import java.lang.String;

public final class CampusVisitSelectViewBinding implements ViewBinding {
  @NonNull
  private final ConstraintLayout rootView;

  @NonNull
  public final RecyclerView campusListView;

  @NonNull
  public final AppCompatTextView title;

  private CampusVisitSelectViewBinding(@NonNull ConstraintLayout rootView,
      @NonNull RecyclerView campusListView, @NonNull AppCompatTextView title) {
    this.rootView = rootView;
    this.campusListView = campusListView;
    this.title = title;
  }

  @Override
  @NonNull
  public ConstraintLayout getRoot() {
    return rootView;
  }

  @NonNull
  public static CampusVisitSelectViewBinding inflate(@NonNull LayoutInflater inflater) {
    return inflate(inflater, null, false);
  }

  @NonNull
  public static CampusVisitSelectViewBinding inflate(@NonNull LayoutInflater inflater,
      @Nullable ViewGroup parent, boolean attachToParent) {
    View root = inflater.inflate(R.layout.campus_visit_select_view, parent, false);
    if (attachToParent) {
      parent.addView(root);
    }
    return bind(root);
  }

  @NonNull
  public static CampusVisitSelectViewBinding bind(@NonNull View rootView) {
    // The body of this method is generated in a way you would not otherwise write.
    // This is done to optimize the compiled bytecode for size and performance.
    int id;
    missingId: {
      id = R.id.campusListView;
      RecyclerView campusListView = ViewBindings.findChildViewById(rootView, id);
      if (campusListView == null) {
        break missingId;
      }

      id = R.id.title;
      AppCompatTextView title = ViewBindings.findChildViewById(rootView, id);
      if (title == null) {
        break missingId;
      }

      return new CampusVisitSelectViewBinding((ConstraintLayout) rootView, campusListView, title);
    }
    String missingId = rootView.getResources().getResourceName(id);
    throw new NullPointerException("Missing required view with ID: ".concat(missingId));
  }
}