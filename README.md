[![Pub Version](https://img.shields.io/pub/v/dart_code_metrics_annotations?logo=dart&logoColor=white)](https://pub.dev/packages/dart_code_metrics_annotations/)
[![License](https://img.shields.io/github/license/CQLabs/dart-code-metrics-presets)](https://github.com/CQLabs/dart-code-metrics-presets/blob/main/LICENSE)
[![package publisher](https://img.shields.io/pub/publisher/dart_code_metrics.svg)](https://pub.dev/packages/dart_code_metrics/publisher)

# DCM Annotations

DCM is an advanced linter for Dart and Flutter that helps you analyze and improve your code quality. You can find all available lint rules [here](https://dcm.dev/docs/rules/).

## `@Throws()`

Used to annotate getters, methods, functions, parameters or local variables that can throw an exception (or multiple exceptions/errors) and therefore an invocation of such declarations must explicitly handle that exception.

For example:

```dart
@Throws()
void fn() { /* ... */ }

@Throws({IndexError})
void anotherFn() { /* ... */ }

void main() {
  try {
    fn(); // OK.
  } catch(_) {}

  fn(); // LINT.

  try {
    anotherFn(); // OK.
  } catch(_) {}

  try {
    anotherFn(); // LINT.
  } on Exception catch(_) {}
}
```

DCM will provide feedback if:

- an invocation of a declaration with this annotation has unhandled exceptions
- a declaration is **not** marked with this annotation, but can throw an exception
- a declaration is marked with this annotation, but does not have any invocation that throws an exception

For more information, see the documentation for [handle-throwing-invocations](https://dcm.dev/docs/rules/common/handle-throwing-invocations/) and [prefer-correct-throws](https://dcm.dev/docs/rules/common/prefer-correct-throws/).

## `@AcceptedTypes()`

Used to annotate fields or parameters that have a type `Object`, but should only receive a known subset of types (e.g. `String` and `int`).

For example:

```dart
void fn() {
  fn(1); // LINT
  SomeClass(false); // LINT
}

void fn(@AcceptedTypes({String, bool}) Object value) {}

class SomeClass {
  @AcceptedTypes({String, int})
  final Object field;

  const SomeClass(this.field);
}
```

DCM will provide feedback if an invocation receives an argument that does not match the type listed in the `@AcceptedTypes()`.

For more information, see the documentation for [pass-correct-accepted-types](https://dcm.dev/docs/rules/common/pass-correct-accepted-type/).

## `@mutated`

Used to annotate parameters or variables that are changed/updated within the function/method body.

For example, the `avoid-collection-mutating-methods` and `avoid-mutating-parameters` rules will not trigger on annotated parameters and `avoid-not-assignable-collection-types` will include such parameters into its analysis.

DCM will provide feedback if the `@mutated` annotation is missing or unnecessary.

For more information, see the documentation for [prefer-correct-mutated](https://dcm.dev/docs/rules/common/prefer-correct-mutated/) and other rules mentioned above.

## How to use annotations

Take these steps to use annotations:

1. Install this package as a **regular** dependency:

   ```terminal
   dart pub add dart_code_metrics_annotations
   ```

   or:

   ```terminal
   flutter pub add dart_code_metrics_annotations
   ```

2. Enable rules that rely on DCM annotations and add those annotations to your code.
