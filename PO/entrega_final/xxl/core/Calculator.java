package xxl.core;

import java.util.List;
import java.util.ArrayList;


import java.io.IOException;
import java.io.FileNotFoundException;
import java.io.FileInputStream;
import java.io.ObjectInputStream;
import java.io.FileOutputStream;
import java.io.ObjectOutputStream;


import xxl.core.exception.ImportFileException;
import xxl.core.exception.MissingFileAssociationException;
import xxl.core.exception.UnavailableFileException;
import xxl.core.exception.UnrecognizedEntryException;


/**
 * Class representing a spreadsheet application.
 */
public class Calculator {
  /** The current spreadsheet. */
  private Spreadsheet _activeSpreadSheet;
  private String _filename;

  private User _activeUser;
  private List<User> _users = new ArrayList<>();

  public Calculator() {
    _activeUser = new User("root");
  }

  public String getFileName() {
    return _filename;
  }

  /**
   * Creates a new spreadsheet and sets it as the active spreadsheet
   *
   * @param lines number of lines of the new spreadsheet
   * @param columns number of columns of the new spreadsheet
   */
  public void createNewSpreadSheet(int lines, int columns) {
    _activeSpreadSheet = new Spreadsheet(lines, columns);
    _activeUser.addSpreadSheet(_activeSpreadSheet);

  }

  /**
   * Return the current spreadsheet.
   *
   * @returns the current spreadsheet of this application. This reference can be null.
   */
  public final Spreadsheet getSpreadsheet() {
    return _activeSpreadSheet;
  }

  /**
   * Saves the serialized application's state into the file associated to the current network.
   *
   * @throws FileNotFoundException if for some reason the file cannot be created or opened. 
   * @throws MissingFileAssociationException if the current network does not have a file.
   * @throws IOException if there is some error while serializing the state of the network to disk.
   */
  public void save() throws UnavailableFileException, FileNotFoundException,
          MissingFileAssociationException, IOException {
    if (_activeSpreadSheet.getChanged()) {
      ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream(_filename));
      out.writeObject(_activeSpreadSheet);
      out.close();
      _activeSpreadSheet.setChanged(false);
    }
  }
  
  /**
   * Saves the serialized application's state into the specified file. The current network is
   * associated to this file.
   *
   * @param filename the name of the file.
   * @throws FileNotFoundException if for some reason the file cannot be created or opened.
   * @throws MissingFileAssociationException if the current network does not have a file.
   * @throws IOException if there is some error while serializing the state of the network to disk.
   */
  public void saveAs(String filename) throws UnavailableFileException, FileNotFoundException,
          MissingFileAssociationException, IOException {
      _filename = filename;
      save();
  }
  
  /**
   * @param filename name of the file containing the serialized application's state
   *        to load.
   * @throws UnavailableFileException if the specified file does not exist or there is
   *         an error while processing this file.
   */

  public void load(String filename) throws UnavailableFileException, MissingFileAssociationException {
    try(ObjectInputStream in = new ObjectInputStream(new FileInputStream(filename))) {
      _activeSpreadSheet = (Spreadsheet) in.readObject();
      _filename = filename;
    } catch (ClassNotFoundException | IOException e) {
      throw new UnavailableFileException(filename);
    }
  }

  
  /**
   * Read text input file and create domain entities.
   *
   * @param filename name of the text input file
   * @throws ImportFileException
   */
  public void importFile(String filename) throws ImportFileException {
    try {
      // parses the new spreadsheet and sets it as the active one
      Parser p = new Parser();

      _activeSpreadSheet = p.parseFile(filename);
    } catch (IOException | UnrecognizedEntryException e) {
      throw new ImportFileException(filename, e);
    }
  } 
}
