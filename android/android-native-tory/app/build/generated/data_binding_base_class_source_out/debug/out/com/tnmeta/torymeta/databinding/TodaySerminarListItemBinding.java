// Generated by view binder compiler. Do not edit!
package com.tnmeta.torymeta.databinding;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.widget.AppCompatImageButton;
import androidx.appcompat.widget.AppCompatTextView;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.viewbinding.ViewBinding;
import androidx.viewbinding.ViewBindings;
import com.tnmeta.torymeta.R;
import java.lang.NullPointerException;
import java.lang.Override;
import java.lang.String;

public final class TodaySerminarListItemBinding implements ViewBinding {
  @NonNull
  private final ConstraintLayout rootView;

  @NonNull
  public final AppCompatImageButton imgDetail;

  @NonNull
  public final View imgStart;

  @NonNull
  public final AppCompatTextView seminarDate;

  @NonNull
  public final AppCompatTextView seminarTeacher;

  @NonNull
  public final AppCompatTextView seminarTitle;

  private TodaySerminarListItemBinding(@NonNull ConstraintLayout rootView,
      @NonNull AppCompatImageButton imgDetail, @NonNull View imgStart,
      @NonNull AppCompatTextView seminarDate, @NonNull AppCompatTextView seminarTeacher,
      @NonNull AppCompatTextView seminarTitle) {
    this.rootView = rootView;
    this.imgDetail = imgDetail;
    this.imgStart = imgStart;
    this.seminarDate = seminarDate;
    this.seminarTeacher = seminarTeacher;
    this.seminarTitle = seminarTitle;
  }

  @Override
  @NonNull
  public ConstraintLayout getRoot() {
    return rootView;
  }

  @NonNull
  public static TodaySerminarListItemBinding inflate(@NonNull LayoutInflater inflater) {
    return inflate(inflater, null, false);
  }

  @NonNull
  public static TodaySerminarListItemBinding inflate(@NonNull LayoutInflater inflater,
      @Nullable ViewGroup parent, boolean attachToParent) {
    View root = inflater.inflate(R.layout.today_serminar_list_item, parent, false);
    if (attachToParent) {
      parent.addView(root);
    }
    return bind(root);
  }

  @NonNull
  public static TodaySerminarListItemBinding bind(@NonNull View rootView) {
    // The body of this method is generated in a way you would not otherwise write.
    // This is done to optimize the compiled bytecode for size and performance.
    int id;
    missingId: {
      id = R.id.img_detail;
      AppCompatImageButton imgDetail = ViewBindings.findChildViewById(rootView, id);
      if (imgDetail == null) {
        break missingId;
      }

      id = R.id.img_start;
      View imgStart = ViewBindings.findChildViewById(rootView, id);
      if (imgStart == null) {
        break missingId;
      }

      id = R.id.seminar_date;
      AppCompatTextView seminarDate = ViewBindings.findChildViewById(rootView, id);
      if (seminarDate == null) {
        break missingId;
      }

      id = R.id.seminar_teacher;
      AppCompatTextView seminarTeacher = ViewBindings.findChildViewById(rootView, id);
      if (seminarTeacher == null) {
        break missingId;
      }

      id = R.id.seminar_title;
      AppCompatTextView seminarTitle = ViewBindings.findChildViewById(rootView, id);
      if (seminarTitle == null) {
        break missingId;
      }

      return new TodaySerminarListItemBinding((ConstraintLayout) rootView, imgDetail, imgStart,
          seminarDate, seminarTeacher, seminarTitle);
    }
    String missingId = rootView.getResources().getResourceName(id);
    throw new NullPointerException("Missing required view with ID: ".concat(missingId));
  }
}
