package xxl.core;
import com.sun.source.tree.TryTree;
import xxl.app.exception.UnknownFunctionException;
import xxl.core.*;
// FIXME import classes

import java.io.Serial;
import java.io.Serializable;
import java.util.*;

import xxl.app.exception.InvalidCellRangeException;
import xxl.core.exception.*;

/**
 * Class representing a spreadsheet.
 */
public class Spreadsheet implements Serializable {
  @Serial
  private static final long serialVersionUID = 202308312359L;

  // FIXME define attributes
  private final int _rows;
  private final int _columns;
  private boolean _changed;
  private Data _cells;
  private List<User> _users = new ArrayList<>();
  private CutBuffer _cutBuffer = new CutBuffer();

  /**
   * Constructor: Creates and instance of the 'SpreadSheet' class
   *              with a number of rows and columns
   *
   * @param rows number of rows of the spreadsheet
   * @param columns number of columns of the spreadsheet
   */


  public Spreadsheet(int rows, int columns) {
    _rows = rows;
    _columns = columns;
    _cells = new Data(_rows, _columns);
  }

  public int getRows() {
    return _rows;
  }

  public int getColumns() {
    return _columns;
  }

  public Boolean getChanged() {
    return _changed;
  }

  public void setChanged(boolean changed) {
    _changed = changed;
  }

  /**
   * Provides the cell found in Data with the specified position
   *
   * @param row     the row of the cell
   * @param column  the column of the cell
   * @return the cell in the specified position
   */
  public Cell getCell(int row, int column) {
    return _cells.getCellFromData(row, column);
  }


  /**
   * Set specified content in specified address.
   *
   * @param row     the row of the cell to change
   * @param column  the column of the cell to change
   * @param content the specification in a string format of the content to put
   *                in the specified cell.
   * @throws InvalidCellAddressException if the address are out of the spreadsheet bounds.
   */
  void setContent(int row, int column, Content content) throws InvalidCellAddressException {
    if (!checkAddress(row, column))
      throw new InvalidCellAddressException(row, column, this);
    Content contentAux;
    Cell cell = _cells.getCellFromData(row, column);
    try { contentAux = cell.getContent(); }
    catch (EmptyCellException e) {
      _cells.addContent2Data(row, column, content);
      this.setChanged(true);
      return; }
    Visitor v = new VisitorName();
    if (contentAux != null && contentAux.accept(v).equals("Function")){
      Function function = (Function) contentAux;
      function.unsubscribe();
    }
    _cells.addContent2Data(row, column, content);
    _changed = true;
  }


  /**
   * Deletes the content in a specified address.
   *
   * @param row     the row of the cell with the content to delete
   * @param column  the column of the cell with the content to delete

   * @throws InvalidCellAddressException if the address is out of the spreadsheet bounds.
   */
  void deleteContent(int row, int column) throws InvalidCellAddressException {
    if (!checkAddress(row, column))
      throw new InvalidCellAddressException(row, column, this);
    Content content;
    Cell cell = _cells.getCellFromData(row, column);
    try { content = cell.getContent(); }
    catch (EmptyCellException e) {
      _cells.deleteCellFromData(row, column);
      _changed = true;
      return; }
    Visitor v = new VisitorName();
    if (content != null && content.accept(v).equals("Function")){
      Function function = (Function) content;
      function.unsubscribe();
    }
    _cells.deleteCellFromData(row, column);
    _changed = true;
  }

  /**
   * Parses a string and creates the corresponding range
   *
   * @param range description of the range to create

   * @throws InvalidRangeException if the addresses of the limiting cells
   *                               are out of the spreadsheet bounds.
   * @return a new, parsed range
   */
  Range createRange(String range) throws InvalidRangeException {
    String[] rangeCoordinates;
    int firstRow, firstColumn, lastRow, lastColumn;
    boolean horizontal = false;

    if (range.indexOf(':') != -1) {
      rangeCoordinates = range.split("[:;]");
      firstRow = Integer.parseInt(rangeCoordinates[0]);
      firstColumn = Integer.parseInt(rangeCoordinates[1]);
      lastRow = Integer.parseInt(rangeCoordinates[2]);
      lastColumn = Integer.parseInt(rangeCoordinates[3]);
    } else {
      rangeCoordinates = range.split(";");
      firstRow = lastRow = Integer.parseInt(rangeCoordinates[0]);
      firstColumn = lastColumn = Integer.parseInt(rangeCoordinates[1]);
    }

    if (!checkRangeCoordinates(firstRow, firstColumn, lastRow, lastColumn)) {
      throw new InvalidRangeException(range, this);
    }
    // assigns the orientation of the range (horizontal or vertical)
    if (firstRow == lastRow)
      horizontal = true;
    return new Range(firstRow, firstColumn, lastRow, lastColumn, this);
  }


  /**
   * Checks if the range coordinates are inside spreadsheet bounds
   *
   * @param firstRow first row of the range
   * @param firstColumn first column of the range
   * @param lastRow last row of the range
   * @param lastColumn last column of the range
   *
   * @return boolean confirmation whether the coordinates are in or out of spreadsheet bounds
   */
  private boolean checkRangeCoordinates(int firstRow, int firstColumn, int lastRow, int lastColumn) {
    return (firstRow > 0 && lastRow <= _rows && firstRow <= lastRow) &&
            (firstColumn > 0 && lastColumn <= _columns && firstColumn <= lastColumn) &&
            (firstRow == lastRow || firstColumn == lastColumn);
  }

  /**
   * Checks if the cell coordinates are inside spreadsheet bounds
   *
   * @param row row of the cell
   * @param column column of the cell
   *
   * @return confirmation whether the coordinates are in or out of spreadsheet bounds
   */
  boolean checkAddress(int row, int column) {
    return (row > 0 && row <= _rows && column > 0 && column <= _columns);
  }

  public List<Cell> getRangeFromSpreadsheet(String range) throws InvalidRangeException {
    Range aux = createRange(range);
    return aux.getCells();
  }

  /**
   * Inserts a specified content in a specified range.
   *
   * @param stringRange description of the range to insert the content to
   * @param stringContent description of the content to be inserted in the range

   * @throws InvalidCellAddressException if the address is out of the spreadsheet bounds.
   * @throws UnrecognizedEntryException  if an entry is not correct
   * @throws InvalidRangeException if the range is not within the spreadsheet
   */
  public void insertContentInRange(String stringRange, String stringContent) throws UnrecognizedEntryException,
          InvalidCellAddressException, InvalidRangeException, UnknownFunctionException {

    Parser p = new Parser(this);
    int counter = 0;
    try {
      Content content = p.parseContent(stringContent);
      Range range = this.createRange(stringRange);

    for (Cell cell : range.getCells()) {
      this.setContent(cell.getRow(), cell.getColumn(), content);
      counter++;
    }
    } catch (UnrecognizedEntryException e) {
      throw new UnknownFunctionException(e.getEntrySpecification());
    }

    if (counter > 0) // If any cell was altered
      _changed = true;
  }

  /**
   * Deletes the content in a specified range.
   *
   * @param stringRange description of the range to delete the content of
   *
   * @throws InvalidRangeException if the range is not within the spreadsheet
   */
  public void deleteContentInRange(String stringRange) throws InvalidRangeException {

    Range range = this.createRange(stringRange);
    int counter = 0;

    for (Cell cell : range.getCells()) {
      try {
        this.deleteContent(cell.getRow(), cell.getColumn());
        counter++;
      } catch (InvalidCellAddressException e) {
        throw new InvalidRangeException(stringRange, this);
      }
    }
    if (counter > 0)
      _changed = true;
  }
  /**
   * Provides the cells of the associated CutBuffer
   *
   * @return the cells of the CutBuffer in an unchangeable form
   **
   */
  public List<Cell> getCutBufferCells() {
    return Collections.unmodifiableList(_cutBuffer.getCells());
  }
  /**
   * Creates an independent copy of a range to the associated CutBuffer and
   * deletes its original contents
   *
   * @param stringRange description of the range to copy and delete its contents
   *
   * @throws InvalidRangeException if the range is not within the spreadsheet
   */
  public void cutBufferCut(String stringRange) throws InvalidRangeException {
    this.cutBufferCopy(stringRange);
    this.deleteContentInRange(stringRange);
    _changed = true;
  }
  /**
   * Creates an independent copy of a range to the associated CutBuffer
   *
   * @param stringRange description of the range to copy and delete its contents
   *
   * @throws InvalidRangeException if the range is not within the spreadsheet
   */
  public void cutBufferCopy(String stringRange) throws InvalidRangeException {
    Range range = this.createRange(stringRange);
    _cutBuffer.copyRangeToCutBuffer(range);
  }

  /**
   * Pastes the range to the SpreadSheet in different ways
   *
   * @param stringRange the range of the cell to change
   */
  public void cutBufferPaste(String stringRange) throws InvalidRangeException {
    if (!stringRange.contains(":"))
      stringRange = stringRange+":"+stringRange;

    Range range = this.createRange(stringRange);
    int cutBufferSize = _cutBuffer.getSize();
    int rangeSize = range.getSize();

    if (cutBufferSize == 0) {
      return;
    }

    if (rangeSize == 1) {
      if (_cutBuffer.getHorizontal()) {
        pasteRowToOneCell(range);
        _changed = true;
      } else {
        pasteColumnToOneCell(range);
        _changed = true;
      }
    } else if (cutBufferSize != rangeSize) {
      return;
    }
    pasteSameSize(range);
  }

  /**
   * Pastes a row to one cell, horizontally
   *
   * @param range the range of cells to paste
   */
  void pasteRowToOneCell(Range range) {
    // Avançar nas colunas da spreasheet começando na coluna da cell do range
    // ao mesmo tempo avançar na celula do cutbuffer
    List<Cell> cutBufferList = _cutBuffer.getCells();
    List<Cell> rangeList = range.getCells();
    Content content2paste;

    int j = 0;
    for (int i = range.getBeginColumn(); i <= _columns && j < cutBufferList.size(); i++) {
      try {
        content2paste = cutBufferList.get(j).copyContent();
        j++;
      } catch (EmptyCellException eip) {
        content2paste = null;
        j++;
      }
      try {
        this.deleteContent(rangeList.get(0).getRow(), i);
        this.setContent(rangeList.get(0).getRow(), i, content2paste);
      } catch (InvalidCellAddressException etr) { continue; }
    }
    _changed = true;
  }

  /**
   * Pastes a column to one cell, vertically
   *
   * @param range the range cells to paste
   */
  void pasteColumnToOneCell(Range range) {
    List<Cell> cutBufferList = _cutBuffer.getCells();
    List<Cell> rangeList = range.getCells();
    Content content2paste;

    int j = 0;
    for (int i = range.getBeginRow(); i <= _rows && j < cutBufferList.size(); i++) {
      try {
        content2paste = cutBufferList.get(j).copyContent();
        j++;
      } catch (EmptyCellException eip) {
        content2paste = null;
        j++;
      }
      try {
        this.deleteContent(i, rangeList.get(0).getColumn());
        this.setContent(i, rangeList.get(0).getColumn(), content2paste);
      } catch (InvalidCellAddressException etr) { continue; }
    }
    _changed = true;
  }

  /**
   * Pastes the CutBuffer cells to a range with the same size
   * Pastes on the orientation of the range
   *
   * @param range the range of cells to paste
   */
  void pasteSameSize(Range range) {
    if (range.getHorizontal()) {
      pasteSameSizeHorizontal(range);

    } else
      pasteSameSizeVertical(range);
  }
  /**
   * Pastes the CutBuffer cells to a range with the same size, horizontally
   *
   * @param range the range of cells to paste
   */

  void pasteSameSizeHorizontal(Range range) {
    Content content2paste;
    List<Cell> cutBufferList = _cutBuffer.getCells();
    List<Cell> rangeList = range.getCells();

    int j = 0;
    for (int i = range.getBeginColumn(); i <= range.getEndColumn(); i++) {
      try {
        content2paste = cutBufferList.get(j).copyContent();
        j++;
      } catch (EmptyCellException eip) {
        content2paste = null;
        j++;
      }
      try {
        this.deleteContent(rangeList.get(0).getRow(),i);
        this.setContent(rangeList.get(0).getRow(),i, content2paste);
      } catch (InvalidCellAddressException etr) { continue; }
    }
    _changed = true;
  }

  /**
   * Pastes the CutBuffer cells to a range with the same size, vertically
   *
   * @param range the range of cells to paste
   */
  void pasteSameSizeVertical(Range range) {
    Content content2paste;
    List<Cell> cutBufferList = _cutBuffer.getCells();
    List<Cell> rangeList = range.getCells();

    int j = 0;
    for (int i = range.getBeginRow(); i <= range.getEndRow(); i++) {
      try {
        content2paste = cutBufferList.get(j).copyContent();
        j++;
      } catch (EmptyCellException eip) {
        content2paste = null;
        j++;
      }
      try {
        this.deleteContent(i, rangeList.get(0).getColumn());
        this.setContent(i, rangeList.get(0).getColumn(), content2paste);
      } catch (InvalidCellAddressException etr) { continue; }
    }
    _changed = true;
  }

  /**
   * Searches the Spreasheet cells for a specific value
   *
   * @param value value to be searched for
   * @return list of cells with that value
   */
  public List<Cell> searchByValue(String value) throws UnrecognizedEntryException {
    Parser p = new Parser();
    Content content;
    try {
      content = p.parseContent(value);
    } catch (InvalidCellAddressException icr) {
        throw new UnrecognizedEntryException(value);
    }

    List<Cell> searchList = new ArrayList<>();
    for (int i = 1; i <= _rows; i++) {
      for (int j = 1; j <= _columns; j++) {
        try {
          if (getCell(i, j).value().equals(content.value()))
            searchList.add(getCell(i, j));
        } catch (EmptyCellException eiu) {
          continue;
        }
      }
    }
    return searchList;
  }

  /**
   * Searches the Spreasheet cells and provides those that contain a specific function name
   *
   * @param functionName name to be searched for
   * @return list of cells whose name contains the name parameter
   */
  public List<Cell> searchByFunctionName(String functionName) throws UnrecognizedEntryException {
    List<Cell> searchList = new ArrayList<>();
    for (int i = 1; i <= _rows; i++) {
      for (int j = 1; j <= _columns; j++) {
        try {
          Visitor v = new VisitorName();
          if(this.getCell(i,j).getContent().accept(v).equals("Function"))
            if(((Function) getCell(i,j).getContent()).getName().contains(functionName))
              searchList.add(getCell(i, j));
        } catch (EmptyCellException eiu) {
          continue;
        }
      }
    }

    // uses a comparator to sort the list by name
    Comparator<Cell> cellComparatorFunctionName = Comparator.comparing(cell -> {
      try {
        return ((Function) cell.getContent()).getName();
      } catch (EmptyCellException e) {
        return "";
      }
    });
    searchList.sort(cellComparatorFunctionName);
    return searchList;
  }
  }
