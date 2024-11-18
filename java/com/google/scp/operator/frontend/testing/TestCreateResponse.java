/*
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.google.scp.operator.frontend.testing;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.auto.value.AutoValue;

/** Used for testing REST responses. */
@AutoValue
public abstract class TestCreateResponse {

  /** Returns a new builder instance for this class. */
  public static TestCreateResponse.Builder builder() {
    return new AutoValue_TestCreateResponse.Builder();
  }

  /** Get the ACK ID. */
  @JsonProperty("ack_id")
  public abstract String ackId();

  /** Builder class for creating instances of the {@code TestCreateResponse} class. */
  @AutoValue.Builder
  public interface Builder {

    /** Set the ACK ID. */
    @JsonProperty("ack_id")
    Builder ackId(String ackId);

    /** Create a new instance of the {@code TestCreateResponse} class from the builder. */
    TestCreateResponse build();
  }
}
