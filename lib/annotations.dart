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
