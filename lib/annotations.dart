/// Used to annotate getters, methods, functions, parameters or local variables
/// that can throw an exception (or multiple exceptions/errors) and therefore
/// an invocation of such declarations must explicitly handle that exception.
///
/// The intention of this annotation is to help avoid unhandled exceptions.
///
/// For example:
///
/// ```dart
/// @Throws()
/// void fn() { /* ... */ }
///
/// @Throws({IndexError})
/// void anotherFn() { /* ... */ }
///
/// void main() {
///   try {
///     fn(); // OK.
///   } catch(_) {}
///
///   fn(); // LINT.
///
///   try {
///     anotherFn(); // OK.
///   } catch(_) {}
///
///   try {
///     anotherFn(); // LINT.
///   } on Exception catch(_) {}
/// }
/// ```
///
/// DCM will provide feedback if
///
/// * an invocation of a declaration with this annotation has unhandled exceptions
/// * a declaration is **not** marked with this annotation, but can throw an exception
/// * a declaration is marked with this annotation, but does not have any invocation that throws an exception
///
/// For more information, see the documentation for "handle-throwing-invocations" and "prefer-correct-throws".
class Throws {
  /// The types of errors or exceptions which the annotated declaration can throw.
  final Set<Type>? expectedErrors;

  /// Create a new instance of [Throws] to be used as an annotation on a declaration
  /// that can throw a set of particular exceptions or errors passed to [expectedErrors]
  /// or any exception if the [expectedErrors] is not specified.
  const Throws([this.expectedErrors]);
}

/// Used to annotate fields or parameters that have a type `Object`,
/// but should only receive a known subset of types (e.g. `String` and `int`).
///
/// The intention of this annotation is to help avoid passing an incorrect
/// or unexpected value.
///
/// For example:
///
/// ```dart
/// void fn() {
///  fn(1); // LINT
///  SomeClass(false); // LINT
/// }
///
/// void fn(@AcceptedTypes({String, bool}) Object value) {}
///
/// class SomeClass {
///  @AcceptedTypes({String, int})
///  final Object field;
///
///  const SomeClass(this.field);
/// }
/// ```
///
/// DCM will provide feedback if an invocation receives an argument that does not match the type listed in the `@AcceptedTypes()`.
///
/// For more information, see the documentation for "pass-correct-accepted-types".
class AcceptedTypes {
  /// The types which the annotated declaration accepts.
  final Set<Type>? types;

  /// Create a new instance of [AcceptedTypes] to be used as an annotation on a declaration
  /// that have an `Object` type, but should only receive a known subset of types.
  const AcceptedTypes(this.types);
}

/// Used to annotate parameters or variables that are changed/updated within the function/method body.
///
/// The intention of this annotation is to help quickly identify which
/// parameters or variables are being mutated.
///
/// For example, the `avoid-collection-mutating-methods` and `avoid-mutating-parameters`
/// rules will not trigger on annotated parameters and `avoid-not-assignable-collection-types`
/// will include such parameters into its analysis.
///
/// DCM will provide feedback if the `@mutated` annotation is missing or unnecessary.
///
/// For more information, see the documentation for "prefer-correct-mutated" and other rules
/// mentioned above.
const _IsMutated mutated = _IsMutated();

class _IsMutated {
  const _IsMutated();
}
