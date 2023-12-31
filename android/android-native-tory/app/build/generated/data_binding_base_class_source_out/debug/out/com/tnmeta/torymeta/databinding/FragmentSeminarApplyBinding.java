// Generated by view binder compiler. Do not edit!
package com.tnmeta.torymeta.databinding;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.widget.AppCompatImageButton;
import androidx.appcompat.widget.AppCompatImageView;
import androidx.appcompat.widget.AppCompatTextView;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.constraintlayout.widget.Guideline;
import androidx.viewbinding.ViewBinding;
import androidx.viewbinding.ViewBindings;
import com.tnmeta.torymeta.R;
import java.lang.NullPointerException;
import java.lang.Override;
import java.lang.String;

public final class FragmentSeminarApplyBinding implements ViewBinding {
  @NonNull
  private final ConstraintLayout rootView;

  @NonNull
  public final ConstraintLayout apply;

  @NonNull
  public final ConstraintLayout buttonLayout;

  @NonNull
  public final ConstraintLayout cancel;

  @NonNull
  public final Guideline guideline;

  @NonNull
  public final AppCompatImageView iconDate;

  @NonNull
  public final AppCompatImageView iconExplanation;

  @NonNull
  public final AppCompatImageView iconLock;

  @NonNull
  public final AppCompatImageView iconPersonnel;

  @NonNull
  public final AppCompatImageView iconSeminar;

  @NonNull
  public final AppCompatImageView iconTeacher;

  @NonNull
  public final AppCompatImageButton ivBack;

  @NonNull
  public final AppCompatTextView seminarCreateTitle;

  @NonNull
  public final ConstraintLayout seminarDateLayout;

  @NonNull
  public final AppCompatTextView seminarDay;

  @NonNull
  public final AppCompatTextView seminarDesc;

  @NonNull
  public final ConstraintLayout seminarDescLayout;

  @NonNull
  public final ConstraintLayout seminarInfoLayout;

  @NonNull
  public final AppCompatTextView seminarMy;

  @NonNull
  public final ConstraintLayout seminarMyCreateLayout;

  @NonNull
  public final AppCompatTextView seminarPersonnel;

  @NonNull
  public final ConstraintLayout seminarPersonnelLayout;

  @NonNull
  public final AppCompatTextView seminarTeacher;

  @NonNull
  public final ConstraintLayout seminarTeacherLayout;

  @NonNull
  public final AppCompatTextView seminarTime;

  @NonNull
  public final AppCompatTextView seminarTitle;

  @NonNull
  public final ConstraintLayout seminarTitleLayout;

  @NonNull
  public final ConstraintLayout topLayout;

  @NonNull
  public final AppCompatTextView txtApply;

  @NonNull
  public final AppCompatTextView txtSeminarDate;

  @NonNull
  public final AppCompatTextView txtSeminarExplanation;

  @NonNull
  public final AppCompatTextView txtSeminarPersonnel;

  @NonNull
  public final AppCompatTextView txtSeminarTeacher;

  @NonNull
  public final AppCompatTextView txtSeminarTitle;

  private FragmentSeminarApplyBinding(@NonNull ConstraintLayout rootView,
      @NonNull ConstraintLayout apply, @NonNull ConstraintLayout buttonLayout,
      @NonNull ConstraintLayout cancel, @NonNull Guideline guideline,
      @NonNull AppCompatImageView iconDate, @NonNull AppCompatImageView iconExplanation,
      @NonNull AppCompatImageView iconLock, @NonNull AppCompatImageView iconPersonnel,
      @NonNull AppCompatImageView iconSeminar, @NonNull AppCompatImageView iconTeacher,
      @NonNull AppCompatImageButton ivBack, @NonNull AppCompatTextView seminarCreateTitle,
      @NonNull ConstraintLayout seminarDateLayout, @NonNull AppCompatTextView seminarDay,
      @NonNull AppCompatTextView seminarDesc, @NonNull ConstraintLayout seminarDescLayout,
      @NonNull ConstraintLayout seminarInfoLayout, @NonNull AppCompatTextView seminarMy,
      @NonNull ConstraintLayout seminarMyCreateLayout, @NonNull AppCompatTextView seminarPersonnel,
      @NonNull ConstraintLayout seminarPersonnelLayout, @NonNull AppCompatTextView seminarTeacher,
      @NonNull ConstraintLayout seminarTeacherLayout, @NonNull AppCompatTextView seminarTime,
      @NonNull AppCompatTextView seminarTitle, @NonNull ConstraintLayout seminarTitleLayout,
      @NonNull ConstraintLayout topLayout, @NonNull AppCompatTextView txtApply,
      @NonNull AppCompatTextView txtSeminarDate, @NonNull AppCompatTextView txtSeminarExplanation,
      @NonNull AppCompatTextView txtSeminarPersonnel, @NonNull AppCompatTextView txtSeminarTeacher,
      @NonNull AppCompatTextView txtSeminarTitle) {
    this.rootView = rootView;
    this.apply = apply;
    this.buttonLayout = buttonLayout;
    this.cancel = cancel;
    this.guideline = guideline;
    this.iconDate = iconDate;
    this.iconExplanation = iconExplanation;
    this.iconLock = iconLock;
    this.iconPersonnel = iconPersonnel;
    this.iconSeminar = iconSeminar;
    this.iconTeacher = iconTeacher;
    this.ivBack = ivBack;
    this.seminarCreateTitle = seminarCreateTitle;
    this.seminarDateLayout = seminarDateLayout;
    this.seminarDay = seminarDay;
    this.seminarDesc = seminarDesc;
    this.seminarDescLayout = seminarDescLayout;
    this.seminarInfoLayout = seminarInfoLayout;
    this.seminarMy = seminarMy;
    this.seminarMyCreateLayout = seminarMyCreateLayout;
    this.seminarPersonnel = seminarPersonnel;
    this.seminarPersonnelLayout = seminarPersonnelLayout;
    this.seminarTeacher = seminarTeacher;
    this.seminarTeacherLayout = seminarTeacherLayout;
    this.seminarTime = seminarTime;
    this.seminarTitle = seminarTitle;
    this.seminarTitleLayout = seminarTitleLayout;
    this.topLayout = topLayout;
    this.txtApply = txtApply;
    this.txtSeminarDate = txtSeminarDate;
    this.txtSeminarExplanation = txtSeminarExplanation;
    this.txtSeminarPersonnel = txtSeminarPersonnel;
    this.txtSeminarTeacher = txtSeminarTeacher;
    this.txtSeminarTitle = txtSeminarTitle;
  }

  @Override
  @NonNull
  public ConstraintLayout getRoot() {
    return rootView;
  }

  @NonNull
  public static FragmentSeminarApplyBinding inflate(@NonNull LayoutInflater inflater) {
    return inflate(inflater, null, false);
  }

  @NonNull
  public static FragmentSeminarApplyBinding inflate(@NonNull LayoutInflater inflater,
      @Nullable ViewGroup parent, boolean attachToParent) {
    View root = inflater.inflate(R.layout.fragment_seminar_apply, parent, false);
    if (attachToParent) {
      parent.addView(root);
    }
    return bind(root);
  }

  @NonNull
  public static FragmentSeminarApplyBinding bind(@NonNull View rootView) {
    // The body of this method is generated in a way you would not otherwise write.
    // This is done to optimize the compiled bytecode for size and performance.
    int id;
    missingId: {
      id = R.id.apply;
      ConstraintLayout apply = ViewBindings.findChildViewById(rootView, id);
      if (apply == null) {
        break missingId;
      }

      id = R.id.button_layout;
      ConstraintLayout buttonLayout = ViewBindings.findChildViewById(rootView, id);
      if (buttonLayout == null) {
        break missingId;
      }

      id = R.id.cancel;
      ConstraintLayout cancel = ViewBindings.findChildViewById(rootView, id);
      if (cancel == null) {
        break missingId;
      }

      id = R.id.guideline;
      Guideline guideline = ViewBindings.findChildViewById(rootView, id);
      if (guideline == null) {
        break missingId;
      }

      id = R.id.icon_date;
      AppCompatImageView iconDate = ViewBindings.findChildViewById(rootView, id);
      if (iconDate == null) {
        break missingId;
      }

      id = R.id.icon_explanation;
      AppCompatImageView iconExplanation = ViewBindings.findChildViewById(rootView, id);
      if (iconExplanation == null) {
        break missingId;
      }

      id = R.id.icon_lock;
      AppCompatImageView iconLock = ViewBindings.findChildViewById(rootView, id);
      if (iconLock == null) {
        break missingId;
      }

      id = R.id.icon_personnel;
      AppCompatImageView iconPersonnel = ViewBindings.findChildViewById(rootView, id);
      if (iconPersonnel == null) {
        break missingId;
      }

      id = R.id.icon_seminar;
      AppCompatImageView iconSeminar = ViewBindings.findChildViewById(rootView, id);
      if (iconSeminar == null) {
        break missingId;
      }

      id = R.id.icon_teacher;
      AppCompatImageView iconTeacher = ViewBindings.findChildViewById(rootView, id);
      if (iconTeacher == null) {
        break missingId;
      }

      id = R.id.ivBack;
      AppCompatImageButton ivBack = ViewBindings.findChildViewById(rootView, id);
      if (ivBack == null) {
        break missingId;
      }

      id = R.id.seminar_create_title;
      AppCompatTextView seminarCreateTitle = ViewBindings.findChildViewById(rootView, id);
      if (seminarCreateTitle == null) {
        break missingId;
      }

      id = R.id.seminar_date_layout;
      ConstraintLayout seminarDateLayout = ViewBindings.findChildViewById(rootView, id);
      if (seminarDateLayout == null) {
        break missingId;
      }

      id = R.id.seminar_day;
      AppCompatTextView seminarDay = ViewBindings.findChildViewById(rootView, id);
      if (seminarDay == null) {
        break missingId;
      }

      id = R.id.seminar_desc;
      AppCompatTextView seminarDesc = ViewBindings.findChildViewById(rootView, id);
      if (seminarDesc == null) {
        break missingId;
      }

      id = R.id.seminar_desc_layout;
      ConstraintLayout seminarDescLayout = ViewBindings.findChildViewById(rootView, id);
      if (seminarDescLayout == null) {
        break missingId;
      }

      id = R.id.seminar_info_layout;
      ConstraintLayout seminarInfoLayout = ViewBindings.findChildViewById(rootView, id);
      if (seminarInfoLayout == null) {
        break missingId;
      }

      id = R.id.seminar_my;
      AppCompatTextView seminarMy = ViewBindings.findChildViewById(rootView, id);
      if (seminarMy == null) {
        break missingId;
      }

      id = R.id.seminar_my_create_layout;
      ConstraintLayout seminarMyCreateLayout = ViewBindings.findChildViewById(rootView, id);
      if (seminarMyCreateLayout == null) {
        break missingId;
      }

      id = R.id.seminar_personnel;
      AppCompatTextView seminarPersonnel = ViewBindings.findChildViewById(rootView, id);
      if (seminarPersonnel == null) {
        break missingId;
      }

      id = R.id.seminar_personnel_layout;
      ConstraintLayout seminarPersonnelLayout = ViewBindings.findChildViewById(rootView, id);
      if (seminarPersonnelLayout == null) {
        break missingId;
      }

      id = R.id.seminar_teacher;
      AppCompatTextView seminarTeacher = ViewBindings.findChildViewById(rootView, id);
      if (seminarTeacher == null) {
        break missingId;
      }

      id = R.id.seminar_teacher_layout;
      ConstraintLayout seminarTeacherLayout = ViewBindings.findChildViewById(rootView, id);
      if (seminarTeacherLayout == null) {
        break missingId;
      }

      id = R.id.seminar_time;
      AppCompatTextView seminarTime = ViewBindings.findChildViewById(rootView, id);
      if (seminarTime == null) {
        break missingId;
      }

      id = R.id.seminar_title;
      AppCompatTextView seminarTitle = ViewBindings.findChildViewById(rootView, id);
      if (seminarTitle == null) {
        break missingId;
      }

      id = R.id.seminar_title_layout;
      ConstraintLayout seminarTitleLayout = ViewBindings.findChildViewById(rootView, id);
      if (seminarTitleLayout == null) {
        break missingId;
      }

      id = R.id.topLayout;
      ConstraintLayout topLayout = ViewBindings.findChildViewById(rootView, id);
      if (topLayout == null) {
        break missingId;
      }

      id = R.id.txt_apply;
      AppCompatTextView txtApply = ViewBindings.findChildViewById(rootView, id);
      if (txtApply == null) {
        break missingId;
      }

      id = R.id.txt_seminar_date;
      AppCompatTextView txtSeminarDate = ViewBindings.findChildViewById(rootView, id);
      if (txtSeminarDate == null) {
        break missingId;
      }

      id = R.id.txt_seminar_explanation;
      AppCompatTextView txtSeminarExplanation = ViewBindings.findChildViewById(rootView, id);
      if (txtSeminarExplanation == null) {
        break missingId;
      }

      id = R.id.txt_seminar_personnel;
      AppCompatTextView txtSeminarPersonnel = ViewBindings.findChildViewById(rootView, id);
      if (txtSeminarPersonnel == null) {
        break missingId;
      }

      id = R.id.txt_seminar_teacher;
      AppCompatTextView txtSeminarTeacher = ViewBindings.findChildViewById(rootView, id);
      if (txtSeminarTeacher == null) {
        break missingId;
      }

      id = R.id.txt_seminar_title;
      AppCompatTextView txtSeminarTitle = ViewBindings.findChildViewById(rootView, id);
      if (txtSeminarTitle == null) {
        break missingId;
      }

      return new FragmentSeminarApplyBinding((ConstraintLayout) rootView, apply, buttonLayout,
          cancel, guideline, iconDate, iconExplanation, iconLock, iconPersonnel, iconSeminar,
          iconTeacher, ivBack, seminarCreateTitle, seminarDateLayout, seminarDay, seminarDesc,
          seminarDescLayout, seminarInfoLayout, seminarMy, seminarMyCreateLayout, seminarPersonnel,
          seminarPersonnelLayout, seminarTeacher, seminarTeacherLayout, seminarTime, seminarTitle,
          seminarTitleLayout, topLayout, txtApply, txtSeminarDate, txtSeminarExplanation,
          txtSeminarPersonnel, txtSeminarTeacher, txtSeminarTitle);
    }
    String missingId = rootView.getResources().getResourceName(id);
    throw new NullPointerException("Missing required view with ID: ".concat(missingId));
  }
}
