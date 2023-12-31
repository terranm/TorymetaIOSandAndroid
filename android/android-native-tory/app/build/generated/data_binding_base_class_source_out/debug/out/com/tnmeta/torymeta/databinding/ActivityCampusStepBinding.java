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
import androidx.constraintlayout.widget.Guideline;
import androidx.viewbinding.ViewBinding;
import androidx.viewbinding.ViewBindings;
import com.tnmeta.torymeta.R;
import java.lang.NullPointerException;
import java.lang.Override;
import java.lang.String;

public final class ActivityCampusStepBinding implements ViewBinding {
  @NonNull
  private final ConstraintLayout rootView;

  @NonNull
  public final ConstraintLayout campusInner;

  @NonNull
  public final AppCompatTextView campusInnerTitle;

  @NonNull
  public final ConstraintLayout campusOut;

  @NonNull
  public final AppCompatTextView campusOutTitle;

  @NonNull
  public final AppCompatImageView closeBtn;

  @NonNull
  public final AppCompatImageView divider;

  @NonNull
  public final Guideline guideline;

  @NonNull
  public final AppCompatImageView imgPedInfo;

  @NonNull
  public final AppCompatImageView imgStep01;

  @NonNull
  public final AppCompatImageView imgStep02;

  @NonNull
  public final AppCompatImageView imgStep03;

  @NonNull
  public final AppCompatImageView imgStep04;

  @NonNull
  public final AppCompatImageView mainStepImage;

  @NonNull
  public final ConstraintLayout rewardLayout01;

  @NonNull
  public final ConstraintLayout rewardLayout02;

  @NonNull
  public final ConstraintLayout rewardLayout03;

  @NonNull
  public final ConstraintLayout rewardLayout04;

  @NonNull
  public final ConstraintLayout selectLayout;

  @NonNull
  public final AppCompatTextView stepComment;

  @NonNull
  public final AppCompatTextView stepCount;

  @NonNull
  public final AppCompatTextView stepPerComment;

  @NonNull
  public final AppCompatTextView stepReward01;

  @NonNull
  public final ConstraintLayout stepReward01Layout;

  @NonNull
  public final AppCompatTextView stepReward02;

  @NonNull
  public final ConstraintLayout stepReward02Layout;

  @NonNull
  public final AppCompatTextView stepReward03;

  @NonNull
  public final ConstraintLayout stepReward03Layout;

  @NonNull
  public final AppCompatTextView stepReward04;

  @NonNull
  public final ConstraintLayout stepReward04Layout;

  @NonNull
  public final CommonTopBarBinding topBar;

  @NonNull
  public final ConstraintLayout topBarLayout;

  @NonNull
  public final AppCompatTextView txtStep01;

  @NonNull
  public final AppCompatTextView txtStep02;

  @NonNull
  public final AppCompatTextView txtStep03;

  @NonNull
  public final AppCompatTextView txtStep04;

  private ActivityCampusStepBinding(@NonNull ConstraintLayout rootView,
      @NonNull ConstraintLayout campusInner, @NonNull AppCompatTextView campusInnerTitle,
      @NonNull ConstraintLayout campusOut, @NonNull AppCompatTextView campusOutTitle,
      @NonNull AppCompatImageView closeBtn, @NonNull AppCompatImageView divider,
      @NonNull Guideline guideline, @NonNull AppCompatImageView imgPedInfo,
      @NonNull AppCompatImageView imgStep01, @NonNull AppCompatImageView imgStep02,
      @NonNull AppCompatImageView imgStep03, @NonNull AppCompatImageView imgStep04,
      @NonNull AppCompatImageView mainStepImage, @NonNull ConstraintLayout rewardLayout01,
      @NonNull ConstraintLayout rewardLayout02, @NonNull ConstraintLayout rewardLayout03,
      @NonNull ConstraintLayout rewardLayout04, @NonNull ConstraintLayout selectLayout,
      @NonNull AppCompatTextView stepComment, @NonNull AppCompatTextView stepCount,
      @NonNull AppCompatTextView stepPerComment, @NonNull AppCompatTextView stepReward01,
      @NonNull ConstraintLayout stepReward01Layout, @NonNull AppCompatTextView stepReward02,
      @NonNull ConstraintLayout stepReward02Layout, @NonNull AppCompatTextView stepReward03,
      @NonNull ConstraintLayout stepReward03Layout, @NonNull AppCompatTextView stepReward04,
      @NonNull ConstraintLayout stepReward04Layout, @NonNull CommonTopBarBinding topBar,
      @NonNull ConstraintLayout topBarLayout, @NonNull AppCompatTextView txtStep01,
      @NonNull AppCompatTextView txtStep02, @NonNull AppCompatTextView txtStep03,
      @NonNull AppCompatTextView txtStep04) {
    this.rootView = rootView;
    this.campusInner = campusInner;
    this.campusInnerTitle = campusInnerTitle;
    this.campusOut = campusOut;
    this.campusOutTitle = campusOutTitle;
    this.closeBtn = closeBtn;
    this.divider = divider;
    this.guideline = guideline;
    this.imgPedInfo = imgPedInfo;
    this.imgStep01 = imgStep01;
    this.imgStep02 = imgStep02;
    this.imgStep03 = imgStep03;
    this.imgStep04 = imgStep04;
    this.mainStepImage = mainStepImage;
    this.rewardLayout01 = rewardLayout01;
    this.rewardLayout02 = rewardLayout02;
    this.rewardLayout03 = rewardLayout03;
    this.rewardLayout04 = rewardLayout04;
    this.selectLayout = selectLayout;
    this.stepComment = stepComment;
    this.stepCount = stepCount;
    this.stepPerComment = stepPerComment;
    this.stepReward01 = stepReward01;
    this.stepReward01Layout = stepReward01Layout;
    this.stepReward02 = stepReward02;
    this.stepReward02Layout = stepReward02Layout;
    this.stepReward03 = stepReward03;
    this.stepReward03Layout = stepReward03Layout;
    this.stepReward04 = stepReward04;
    this.stepReward04Layout = stepReward04Layout;
    this.topBar = topBar;
    this.topBarLayout = topBarLayout;
    this.txtStep01 = txtStep01;
    this.txtStep02 = txtStep02;
    this.txtStep03 = txtStep03;
    this.txtStep04 = txtStep04;
  }

  @Override
  @NonNull
  public ConstraintLayout getRoot() {
    return rootView;
  }

  @NonNull
  public static ActivityCampusStepBinding inflate(@NonNull LayoutInflater inflater) {
    return inflate(inflater, null, false);
  }

  @NonNull
  public static ActivityCampusStepBinding inflate(@NonNull LayoutInflater inflater,
      @Nullable ViewGroup parent, boolean attachToParent) {
    View root = inflater.inflate(R.layout.activity_campus_step, parent, false);
    if (attachToParent) {
      parent.addView(root);
    }
    return bind(root);
  }

  @NonNull
  public static ActivityCampusStepBinding bind(@NonNull View rootView) {
    // The body of this method is generated in a way you would not otherwise write.
    // This is done to optimize the compiled bytecode for size and performance.
    int id;
    missingId: {
      id = R.id.campus_inner;
      ConstraintLayout campusInner = ViewBindings.findChildViewById(rootView, id);
      if (campusInner == null) {
        break missingId;
      }

      id = R.id.campus_inner_title;
      AppCompatTextView campusInnerTitle = ViewBindings.findChildViewById(rootView, id);
      if (campusInnerTitle == null) {
        break missingId;
      }

      id = R.id.campus_out;
      ConstraintLayout campusOut = ViewBindings.findChildViewById(rootView, id);
      if (campusOut == null) {
        break missingId;
      }

      id = R.id.campus_out_title;
      AppCompatTextView campusOutTitle = ViewBindings.findChildViewById(rootView, id);
      if (campusOutTitle == null) {
        break missingId;
      }

      id = R.id.closeBtn;
      AppCompatImageView closeBtn = ViewBindings.findChildViewById(rootView, id);
      if (closeBtn == null) {
        break missingId;
      }

      id = R.id.divider;
      AppCompatImageView divider = ViewBindings.findChildViewById(rootView, id);
      if (divider == null) {
        break missingId;
      }

      id = R.id.guideline;
      Guideline guideline = ViewBindings.findChildViewById(rootView, id);
      if (guideline == null) {
        break missingId;
      }

      id = R.id.imgPedInfo;
      AppCompatImageView imgPedInfo = ViewBindings.findChildViewById(rootView, id);
      if (imgPedInfo == null) {
        break missingId;
      }

      id = R.id.imgStep_01;
      AppCompatImageView imgStep01 = ViewBindings.findChildViewById(rootView, id);
      if (imgStep01 == null) {
        break missingId;
      }

      id = R.id.imgStep_02;
      AppCompatImageView imgStep02 = ViewBindings.findChildViewById(rootView, id);
      if (imgStep02 == null) {
        break missingId;
      }

      id = R.id.imgStep_03;
      AppCompatImageView imgStep03 = ViewBindings.findChildViewById(rootView, id);
      if (imgStep03 == null) {
        break missingId;
      }

      id = R.id.imgStep_04;
      AppCompatImageView imgStep04 = ViewBindings.findChildViewById(rootView, id);
      if (imgStep04 == null) {
        break missingId;
      }

      id = R.id.mainStepImage;
      AppCompatImageView mainStepImage = ViewBindings.findChildViewById(rootView, id);
      if (mainStepImage == null) {
        break missingId;
      }

      id = R.id.reward_layout_01;
      ConstraintLayout rewardLayout01 = ViewBindings.findChildViewById(rootView, id);
      if (rewardLayout01 == null) {
        break missingId;
      }

      id = R.id.reward_layout_02;
      ConstraintLayout rewardLayout02 = ViewBindings.findChildViewById(rootView, id);
      if (rewardLayout02 == null) {
        break missingId;
      }

      id = R.id.reward_layout_03;
      ConstraintLayout rewardLayout03 = ViewBindings.findChildViewById(rootView, id);
      if (rewardLayout03 == null) {
        break missingId;
      }

      id = R.id.reward_layout_04;
      ConstraintLayout rewardLayout04 = ViewBindings.findChildViewById(rootView, id);
      if (rewardLayout04 == null) {
        break missingId;
      }

      id = R.id.select_layout;
      ConstraintLayout selectLayout = ViewBindings.findChildViewById(rootView, id);
      if (selectLayout == null) {
        break missingId;
      }

      id = R.id.stepComment;
      AppCompatTextView stepComment = ViewBindings.findChildViewById(rootView, id);
      if (stepComment == null) {
        break missingId;
      }

      id = R.id.stepCount;
      AppCompatTextView stepCount = ViewBindings.findChildViewById(rootView, id);
      if (stepCount == null) {
        break missingId;
      }

      id = R.id.stepPerComment;
      AppCompatTextView stepPerComment = ViewBindings.findChildViewById(rootView, id);
      if (stepPerComment == null) {
        break missingId;
      }

      id = R.id.step_reward_01;
      AppCompatTextView stepReward01 = ViewBindings.findChildViewById(rootView, id);
      if (stepReward01 == null) {
        break missingId;
      }

      id = R.id.step_reward_01_layout;
      ConstraintLayout stepReward01Layout = ViewBindings.findChildViewById(rootView, id);
      if (stepReward01Layout == null) {
        break missingId;
      }

      id = R.id.step_reward_02;
      AppCompatTextView stepReward02 = ViewBindings.findChildViewById(rootView, id);
      if (stepReward02 == null) {
        break missingId;
      }

      id = R.id.step_reward_02_layout;
      ConstraintLayout stepReward02Layout = ViewBindings.findChildViewById(rootView, id);
      if (stepReward02Layout == null) {
        break missingId;
      }

      id = R.id.step_reward_03;
      AppCompatTextView stepReward03 = ViewBindings.findChildViewById(rootView, id);
      if (stepReward03 == null) {
        break missingId;
      }

      id = R.id.step_reward_03_layout;
      ConstraintLayout stepReward03Layout = ViewBindings.findChildViewById(rootView, id);
      if (stepReward03Layout == null) {
        break missingId;
      }

      id = R.id.step_reward_04;
      AppCompatTextView stepReward04 = ViewBindings.findChildViewById(rootView, id);
      if (stepReward04 == null) {
        break missingId;
      }

      id = R.id.step_reward_04_layout;
      ConstraintLayout stepReward04Layout = ViewBindings.findChildViewById(rootView, id);
      if (stepReward04Layout == null) {
        break missingId;
      }

      id = R.id.topBar;
      View topBar = ViewBindings.findChildViewById(rootView, id);
      if (topBar == null) {
        break missingId;
      }
      CommonTopBarBinding binding_topBar = CommonTopBarBinding.bind(topBar);

      id = R.id.topBar_layout;
      ConstraintLayout topBarLayout = ViewBindings.findChildViewById(rootView, id);
      if (topBarLayout == null) {
        break missingId;
      }

      id = R.id.txtStep_01;
      AppCompatTextView txtStep01 = ViewBindings.findChildViewById(rootView, id);
      if (txtStep01 == null) {
        break missingId;
      }

      id = R.id.txtStep_02;
      AppCompatTextView txtStep02 = ViewBindings.findChildViewById(rootView, id);
      if (txtStep02 == null) {
        break missingId;
      }

      id = R.id.txtStep_03;
      AppCompatTextView txtStep03 = ViewBindings.findChildViewById(rootView, id);
      if (txtStep03 == null) {
        break missingId;
      }

      id = R.id.txtStep_04;
      AppCompatTextView txtStep04 = ViewBindings.findChildViewById(rootView, id);
      if (txtStep04 == null) {
        break missingId;
      }

      return new ActivityCampusStepBinding((ConstraintLayout) rootView, campusInner,
          campusInnerTitle, campusOut, campusOutTitle, closeBtn, divider, guideline, imgPedInfo,
          imgStep01, imgStep02, imgStep03, imgStep04, mainStepImage, rewardLayout01, rewardLayout02,
          rewardLayout03, rewardLayout04, selectLayout, stepComment, stepCount, stepPerComment,
          stepReward01, stepReward01Layout, stepReward02, stepReward02Layout, stepReward03,
          stepReward03Layout, stepReward04, stepReward04Layout, binding_topBar, topBarLayout,
          txtStep01, txtStep02, txtStep03, txtStep04);
    }
    String missingId = rootView.getResources().getResourceName(id);
    throw new NullPointerException("Missing required view with ID: ".concat(missingId));
  }
}
