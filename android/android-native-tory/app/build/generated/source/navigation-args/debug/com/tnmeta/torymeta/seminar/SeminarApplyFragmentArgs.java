package com.tnmeta.torymeta.seminar;

import android.os.Bundle;
import android.os.Parcelable;
import androidx.annotation.NonNull;
import androidx.lifecycle.SavedStateHandle;
import androidx.navigation.NavArgs;
import com.tnmeta.torymeta.main.model.SeminarDto;
import java.io.Serializable;
import java.lang.IllegalArgumentException;
import java.lang.Object;
import java.lang.Override;
import java.lang.String;
import java.lang.SuppressWarnings;
import java.util.HashMap;

public class SeminarApplyFragmentArgs implements NavArgs {
  private final HashMap arguments = new HashMap();

  private SeminarApplyFragmentArgs() {
  }

  @SuppressWarnings("unchecked")
  private SeminarApplyFragmentArgs(HashMap argumentsMap) {
    this.arguments.putAll(argumentsMap);
  }

  @NonNull
  @SuppressWarnings({
      "unchecked",
      "deprecation"
  })
  public static SeminarApplyFragmentArgs fromBundle(@NonNull Bundle bundle) {
    SeminarApplyFragmentArgs __result = new SeminarApplyFragmentArgs();
    bundle.setClassLoader(SeminarApplyFragmentArgs.class.getClassLoader());
    if (bundle.containsKey("param")) {
      SeminarDto param;
      if (Parcelable.class.isAssignableFrom(SeminarDto.class) || Serializable.class.isAssignableFrom(SeminarDto.class)) {
        param = (SeminarDto) bundle.get("param");
      } else {
        throw new UnsupportedOperationException(SeminarDto.class.getName() + " must implement Parcelable or Serializable or must be an Enum.");
      }
      if (param == null) {
        throw new IllegalArgumentException("Argument \"param\" is marked as non-null but was passed a null value.");
      }
      __result.arguments.put("param", param);
    } else {
      throw new IllegalArgumentException("Required argument \"param\" is missing and does not have an android:defaultValue");
    }
    return __result;
  }

  @NonNull
  @SuppressWarnings("unchecked")
  public static SeminarApplyFragmentArgs fromSavedStateHandle(
      @NonNull SavedStateHandle savedStateHandle) {
    SeminarApplyFragmentArgs __result = new SeminarApplyFragmentArgs();
    if (savedStateHandle.contains("param")) {
      SeminarDto param;
      param = savedStateHandle.get("param");
      if (param == null) {
        throw new IllegalArgumentException("Argument \"param\" is marked as non-null but was passed a null value.");
      }
      __result.arguments.put("param", param);
    } else {
      throw new IllegalArgumentException("Required argument \"param\" is missing and does not have an android:defaultValue");
    }
    return __result;
  }

  @SuppressWarnings("unchecked")
  @NonNull
  public SeminarDto getParam() {
    return (SeminarDto) arguments.get("param");
  }

  @SuppressWarnings("unchecked")
  @NonNull
  public Bundle toBundle() {
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

  @SuppressWarnings("unchecked")
  @NonNull
  public SavedStateHandle toSavedStateHandle() {
    SavedStateHandle __result = new SavedStateHandle();
    if (arguments.containsKey("param")) {
      SeminarDto param = (SeminarDto) arguments.get("param");
      if (Parcelable.class.isAssignableFrom(SeminarDto.class) || param == null) {
        __result.set("param", Parcelable.class.cast(param));
      } else if (Serializable.class.isAssignableFrom(SeminarDto.class)) {
        __result.set("param", Serializable.class.cast(param));
      } else {
        throw new UnsupportedOperationException(SeminarDto.class.getName() + " must implement Parcelable or Serializable or must be an Enum.");
      }
    }
    return __result;
  }

  @Override
  public boolean equals(Object object) {
    if (this == object) {
        return true;
    }
    if (object == null || getClass() != object.getClass()) {
        return false;
    }
    SeminarApplyFragmentArgs that = (SeminarApplyFragmentArgs) object;
    if (arguments.containsKey("param") != that.arguments.containsKey("param")) {
      return false;
    }
    if (getParam() != null ? !getParam().equals(that.getParam()) : that.getParam() != null) {
      return false;
    }
    return true;
  }

  @Override
  public int hashCode() {
    int result = 1;
    result = 31 * result + (getParam() != null ? getParam().hashCode() : 0);
    return result;
  }

  @Override
  public String toString() {
    return "SeminarApplyFragmentArgs{"
        + "param=" + getParam()
        + "}";
  }

  public static final class Builder {
    private final HashMap arguments = new HashMap();

    @SuppressWarnings("unchecked")
    public Builder(@NonNull SeminarApplyFragmentArgs original) {
      this.arguments.putAll(original.arguments);
    }

    @SuppressWarnings("unchecked")
    public Builder(@NonNull SeminarDto param) {
      if (param == null) {
        throw new IllegalArgumentException("Argument \"param\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("param", param);
    }

    @NonNull
    public SeminarApplyFragmentArgs build() {
      SeminarApplyFragmentArgs result = new SeminarApplyFragmentArgs(arguments);
      return result;
    }

    @NonNull
    @SuppressWarnings("unchecked")
    public Builder setParam(@NonNull SeminarDto param) {
      if (param == null) {
        throw new IllegalArgumentException("Argument \"param\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("param", param);
      return this;
    }

    @SuppressWarnings({"unchecked","GetterOnBuilder"})
    @NonNull
    public SeminarDto getParam() {
      return (SeminarDto) arguments.get("param");
    }
  }
}
