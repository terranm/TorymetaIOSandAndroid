package com.tnmeta.torymeta.seminar;

import android.os.Bundle;
import android.os.Parcelable;
import androidx.annotation.NonNull;
import androidx.navigation.NavDirections;
import com.tnmeta.torymeta.NavMainDirections;
import com.tnmeta.torymeta.R;
import com.tnmeta.torymeta.main.model.SeminarDto;
import java.io.Serializable;
import java.lang.IllegalArgumentException;
import java.lang.Object;
import java.lang.Override;
import java.lang.String;
import java.lang.SuppressWarnings;
import java.util.HashMap;

public class SeminarScheduleFragmentDirections {
  private SeminarScheduleFragmentDirections() {
  }

  @NonNull
  public static ActionSeminarScheduleToApplySeminar actionSeminarScheduleToApplySeminar(
      @NonNull SeminarDto param) {
    return new ActionSeminarScheduleToApplySeminar(param);
  }

  @NonNull
  public static NavDirections actionGlobalSignFlowFragment() {
    return NavMainDirections.actionGlobalSignFlowFragment();
  }

  public static class ActionSeminarScheduleToApplySeminar implements NavDirections {
    private final HashMap arguments = new HashMap();

    @SuppressWarnings("unchecked")
    private ActionSeminarScheduleToApplySeminar(@NonNull SeminarDto param) {
      if (param == null) {
        throw new IllegalArgumentException("Argument \"param\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("param", param);
    }

    @NonNull
    @SuppressWarnings("unchecked")
    public ActionSeminarScheduleToApplySeminar setParam(@NonNull SeminarDto param) {
      if (param == null) {
        throw new IllegalArgumentException("Argument \"param\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("param", param);
      return this;
    }

    @Override
    @SuppressWarnings("unchecked")
    @NonNull
    public Bundle getArguments() {
      Bundle __result = new Bundle();
      if (arguments.containsKey("param")) {
        SeminarDto param = (SeminarDto) arguments.get("param");
        if (Parcelable.class.isAssignableFrom(SeminarDto.class) || param == null) {
          __result.putParcelable("param", Parcelable.class.cast(param));
        } else if (Serializable.class.isAssignableFrom(SeminarDto.class)) {
          __result.putSerializable("param", Serializable.class.cast(param));
        } else {
          throw new UnsupportedOperationException(SeminarDto.class.getName() + " must implement Parcelable or Serializable or must be an Enum.");
        }
      }
      return __result;
    }

    @Override
    public int getActionId() {
      return R.id.action_seminar_schedule_to_apply_seminar;
    }

    @SuppressWarnings("unchecked")
    @NonNull
    public SeminarDto getParam() {
      return (SeminarDto) arguments.get("param");
    }

    @Override
    public boolean equals(Object object) {
      if (this == object) {
          return true;
      }
      if (object == null || getClass() != object.getClass()) {
          return false;
      }
      ActionSeminarScheduleToApplySeminar that = (ActionSeminarScheduleToApplySeminar) object;
      if (arguments.containsKey("param") != that.arguments.containsKey("param")) {
        return false;
      }
      if (getParam() != null ? !getParam().equals(that.getParam()) : that.getParam() != null) {
        return false;
      }
      if (getActionId() != that.getActionId()) {
        return false;
      }
      return true;
    }

    @Override
    public int hashCode() {
      int result = 1;
      result = 31 * result + (getParam() != null ? getParam().hashCode() : 0);
      result = 31 * result + getActionId();
      return result;
    }

    @Override
    public String toString() {
      return "ActionSeminarScheduleToApplySeminar(actionId=" + getActionId() + "){"
          + "param=" + getParam()
          + "}";
    }
  }
}
