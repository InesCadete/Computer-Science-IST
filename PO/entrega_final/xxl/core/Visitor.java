package xxl.core;

public interface Visitor {
    String visitReference(Reference reference);
    String visitLiteralString(LiteralString literalString);
    String visitLiteralInteger(LiteralInteger literalInteger);
    String visitFunction(Function function);
}
