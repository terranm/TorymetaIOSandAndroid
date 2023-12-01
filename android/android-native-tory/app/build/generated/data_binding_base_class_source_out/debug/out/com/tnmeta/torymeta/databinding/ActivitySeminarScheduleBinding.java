// Generated by view binder compiler. Do not edit!
package com.tnmeta.torymeta.databinding;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.widget.AppCompatButton;
import androidx.appcompat.widget.AppCompatImageView;
import androidx.appcompat.widget.AppCompatTextView;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.recyclerview.widget.RecyclerView;
import androidx.viewbinding.ViewBinding;
import androidx.viewbinding.ViewBindings;
import com.tnmeta.torymeta.R;
import java.lang.NullPointerException;
import java.lang.Override;
import java.lang.String;

public final class ActivitySeminarScheduleBinding implements ViewBinding {
  @NonNull
  private final ConstraintLayout rootView;

  @NonNull
  public final ConstraintLayout dateLayout;

  @NonNull
  public final AppCompatTextView emptyView;

  @NonNull
  public final AppCompatButton imgBeforeDay;

  @NonNull
  public final AppCompatButton imgNextDay;

  @NonNull
  public final AppCompatImageView ivBack;

  @NonNull
  public final RecyclerView recyclerView;

  @NonNull
  public final AppCompatTextView title;

  @NonNull
  public final ConstraintLayout topLayout;

  @NonNull
  public final AppCompatTextView txtDate;

  @NonNull
  public final AppCompatTextView txtToday;

  private ActivitySeminarScheduleBinding(@NonNull ConstraintLayout rootView,
      @NonNull ConstraintLayout dateLayout, @NonNull AppCompatTextView emptyView,
      @NonNull AppCompatButton imgBeforeDay, @NonNull AppCompatButton imgNextDay,
      @NonNull AppCompatImageView ivBack, @NonNull RecyclerView recyclerView,
      @NonNull AppCompatTextView title, @NonNull ConstraintLayout topLayout,
      @NonNull AppCompatTextView txtDate, @NonNull AppCompatTextView txtToday) {
    this.rootView = rootView;
    this.dateLayout = dateLayout;
    this.emptyView = emptyView;
    this.imgBeforeDay = imgBeforeDay;
    this.imgNextDay = imgNextDay;
    this.ivBack = ivBack;
    this.recyclerView = recyclerView;
    this.title = title;
    this.topLayout = topLayout;
    this.txtDate = txtDate;
    this.txtToday = txtToday;
  }

  @Override
  @NonNull
  public ConstraintLayout getRoot() {
    return rootView;
  }

  @NonNull
  public static ActivitySeminarScheduleBinding inflate(@NonNull LayoutInflater inflater) {
    return inflate(inflater, null, false);
  }

  @NonNull
  public static ActivitySeminarScheduleBinding inflate(@NonNull LayoutInflater inflater,
      @Nullable ViewGroup parent, boolean attachToParent) {
    View root = inflater.inflate(R.layout.activity_seminar_schedule, parent, false);
    if (attachToParent) {
      parent.addView(root);
    }
    return bind(root);
  }

  @NonNull
  public static ActivitySeminarScheduleBinding bind(@NonNull View rootView) {
    // The body of this method is generated in a way you would not otherwise write.
    // This is done to optimize the compiled bytecode for size and performance.
    int id;
    missingId: {
      id = R.id.date_layout;
      ConstraintLayout dateLayout = ViewBindings.findChildViewById(rootView, id);
      if (dateLayout == null) {
        break missingId;
      }

      id = R.id.emptyView;
      AppCompatTextView emptyView = ViewBindings.findChildViewById(rootView, id);
      if (emptyView == null) {
        break missingId;
      }

      id = R.id.img_before_day;
      AppCompatButton imgBeforeDay = ViewBindings.findChildViewById(rootView, id);
      if (imgBeforeDay == null) {
        break missingId;
      }

      id = R.id.img_next_day;
      AppCompatButton imgNextDay = ViewBindings.findChildViewById(rootView, id);
      if (imgNextDay == null) {
        break missingId;
      }

      id = R.id.ivBack;
      AppCompatImageView ivBack = ViewBindings.findChildViewById(rootView, id);
      if (ivBack == null) {
        break missingId;
      }

      id = R.id.recyclerView;
      RecyclerView recyclerView = ViewBindings.findChildViewById(rootView, id);
      if (recyclerView == null) {
        break missingId;
      }

      id = R.id.title;
      AppCompatTextView title = ViewBindings.findChildViewById(rootView, id);
      if (title == null) {
        break missingId;
      }

      id = R.id.topLayout;
      ConstraintLayout topLayout = ViewBindings.findChildViewById(rootView, id);
      if (topLayout == null) {
        break missingId;
      }

      id = R.id.txtDate;
      AppCompatTextView txtDate = ViewBindings.findChildViewById(rootView, id);
      if (txtDate == null) {
        break missingId;
      }

      id = R.id.txtToday;
      AppCompatTextView txtToday = ViewBindings.findChildViewById(rootView, id);
      if (txtToday == null) {
        break missingId;
      }

      return new ActivitySeminarScheduleBinding((ConstraintLayout) rootView, dateLayout, emptyView,
          imgBeforeDay, imgNextDay, ivBack, recyclerView, title, topLayout, txtDate, txtToday);
    }
    String missingId = rootView.getResources().getResourceName(id);
    throw new NullPointerException("Missing required view with ID: ".concat(missingId));
  }
}