package xxl.core;

import java.io.IOException;
import java.io.FileReader;
import java.io.BufferedReader;
import java.io.Reader;

import java.util.Collection;
import java.util.ArrayList;

import xxl.core.exception.EmptyCellException;
import xxl.core.exception.InvalidCellAddressException;
import xxl.core.exception.InvalidRangeException;
import xxl.core.exception.UnrecognizedEntryException;
import xxl.core.Spreadsheet;

class Parser {

    private Spreadsheet _spreadsheet;

    Parser() {
    }

    Parser(Spreadsheet spreadsheet) {
        _spreadsheet = spreadsheet;
    }

    Spreadsheet parseFile(String filename) throws IOException, UnrecognizedEntryException /* More Exceptions? */ {
        try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            parseDimensions(reader);

            String line;

            while ((line = reader.readLine()) != null)
                parseLine(line);
        }

        return _spreadsheet;
    }

    private void parseDimensions(BufferedReader reader) throws IOException, UnrecognizedEntryException {
        int rows = -1;
        int columns = -1;

        for (int i = 0; i < 2; i++) {
            String line = reader.readLine();
            String[] dimension = line.split("=");
            if (dimension[0].equals("linhas"))
                rows = Integer.parseInt(dimension[1]);
            else if (dimension[0].equals("colunas"))
                columns = Integer.parseInt(dimension[1]);
            else
                throw new UnrecognizedEntryException(line);
        }

        if (rows <= 0 || columns <= 0)
            throw new UnrecognizedEntryException("Dimensões inválidas para a folha");

        _spreadsheet = new Spreadsheet(rows, columns);
    }

    private void parseLine(String line) throws UnrecognizedEntryException /*, more exceptions? */{
        String[] components = line.split("\\|");
        Content content;

        if (components.length == 1) // do nothing
            return;

        if (components.length == 2) {
            String[] address = components[0].split(";");
            try { content = parseContent(components[1]);}
            catch (UnrecognizedEntryException | InvalidCellAddressException ure) {
                throw new UnrecognizedEntryException(ure.getMessage()+"Line: " + line);
            }
            try { _spreadsheet.setContent(Integer.parseInt(address[0]), Integer.parseInt(address[1]), content); }
            catch (InvalidCellAddressException ica) {
                throw new UnrecognizedEntryException(ica.getMessage()+" Line: " + line);
            }
        } else
            throw new UnrecognizedEntryException("Wrong format in line: " + line);
    }

    // parse the beginning of an expression
    Content parseContent(String contentSpecification) throws UnrecognizedEntryException, InvalidCellAddressException {
        char c = contentSpecification.charAt(0);

        if (c == '=')
            return parseContentExpression(contentSpecification.substring(1));
        else
            return parseLiteral(contentSpecification);
    }

    private Literal parseLiteral(String literalExpression) throws UnrecognizedEntryException {
        if (literalExpression.charAt(0) == '\'')
            return new LiteralString(literalExpression);
    else {
            try {
                int val = Integer.parseInt(literalExpression);
                return new LiteralInteger(val);
            } catch (NumberFormatException nfe) {
                throw new UnrecognizedEntryException("Literal inválido: " + literalExpression);
            }
        }
    }

    // contentSpecification is what comes after '='
    private Content parseContentExpression(String contentSpecification) throws UnrecognizedEntryException, InvalidCellAddressException /* more exceptions */ {
        if (contentSpecification.contains("("))
            return parseFunction(contentSpecification);
        // It is a reference
        String[] address = contentSpecification.split(";");
        if (_spreadsheet.checkAddress(Integer.parseInt(address[0].trim()), Integer.parseInt(address[1])))
            return new Reference(Integer.parseInt(address[0].trim()), Integer.parseInt(address[1]), _spreadsheet);
        else {
            throw new InvalidCellAddressException(Integer.parseInt(address[0].trim()), Integer.parseInt(address[1]), _spreadsheet);
        }
    }

    private Content parseFunction(String functionSpecification) throws UnrecognizedEntryException/* more exceptions */ {
        String[] components = functionSpecification.split("[()]");
        if (components[1].contains(","))
            return parseBinaryFunction(components[0], components[1]);

        return parseIntervalFunction(components[0], components[1]);
    }

    private Content parseBinaryFunction(String functionName, String args) throws UnrecognizedEntryException /* , more Exceptions */ {
        String[] arguments = args.split(",");
        Content arg0 = parseArgumentExpression(arguments[0]);
        Content arg1 = parseArgumentExpression(arguments[1]);

        return switch (functionName) {
            case "ADD" -> new Add(arg0, arg1);
            case "SUB" -> new Sub(arg0, arg1);
            case "MUL" -> new Mul(arg0, arg1);
            case "DIV" -> new Div(arg0, arg1);
            default -> throw new UnrecognizedEntryException(functionName);

        };
    }

    private Content parseArgumentExpression(String argExpression) throws UnrecognizedEntryException {
        if (argExpression.contains(";")  && argExpression.charAt(0) != '\'') {
            String[] address = argExpression.split(";");
            return new Reference(Integer.parseInt(address[0].trim()), Integer.parseInt(address[1]), _spreadsheet);
        } else
            return parseLiteral(argExpression);
    }

    private IntervalFunction parseIntervalFunction(String functionName, String rangeDescription)
            throws UnrecognizedEntryException /* , more exceptions ? */ {
                Range range;
        try { range = _spreadsheet.createRange(rangeDescription); }
        catch (InvalidRangeException ire) {
            throw new UnrecognizedEntryException(ire.getMessage());
        }

        return switch (functionName) {

            case "AVERAGE" -> new Average(range);
            case "PRODUCT" -> new Product(range);
            case "CONCAT" -> new Concat(range);
            case "COALESCE" -> new Coalesce(range);
            default -> throw new UnrecognizedEntryException(functionName);
        };
    }


}