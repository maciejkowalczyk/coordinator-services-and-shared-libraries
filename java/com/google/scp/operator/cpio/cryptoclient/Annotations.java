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

package com.google.scp.operator.cpio.cryptoclient;

import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.ElementType.PARAMETER;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

import com.google.inject.BindingAnnotation;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

public final class Annotations {

  /** Aead provider for coordinator A. */
  @BindingAnnotation
  @Target({FIELD, PARAMETER, METHOD})
  @Retention(RUNTIME)
  public @interface CoordinatorAAead {}

  /** Aead provider for coordinator B. */
  @BindingAnnotation
  @Target({FIELD, PARAMETER, METHOD})
  @Retention(RUNTIME)
  public @interface CoordinatorBAead {}

  /**
   * Base URL (e.g. `https://foo.com/v1`) where coordinator A's encryption key vending service is
   * located.
   */
  @BindingAnnotation
  @Target({FIELD, PARAMETER, METHOD})
  @Retention(RUNTIME)
  public @interface CoordinatorAEncryptionKeyServiceBaseUrl {}

  /**
   * Base URL (e.g. `https://foo.com/v1`) where coordinator B's encryption key vending service is
   * located.
   */
  @BindingAnnotation
  @Target({FIELD, PARAMETER, METHOD})
  @Retention(RUNTIME)
  public @interface CoordinatorBEncryptionKeyServiceBaseUrl {}

  /**
   * TTL for private key cache. To be used only for load testing and should not be used by external
   * clients (AdTechs).
   */
  @BindingAnnotation
  @Target({FIELD, PARAMETER, METHOD})
  @Retention(RUNTIME)
  public @interface DecrypterCacheEntryTtlSec {}

  /** TTL for exception cache. */
  @BindingAnnotation
  @Target({FIELD, PARAMETER, METHOD})
  @Retention(RUNTIME)
  public @interface ExceptionCacheEntryTtlSec {}
}
