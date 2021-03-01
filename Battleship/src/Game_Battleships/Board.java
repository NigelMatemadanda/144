package Game_Battleships;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;


public class Board extends JFrame implements ActionListener{
    // An array of buttons to be clicked
    public static JButton[] button = new JButton[100];
    int win = 1;

    // The constructor
    public Board(int rows, int cols) {

        // Set up the pane to hold the grid
        Container pane = getContentPane();
        // and make it a grid layout
        pane.setLayout(new GridLayout(rows, cols, 0, 0));

        // loop through all the buttons
        for (int i = 0; i < 100; i++) {
            // set the buttons to contain the populated array
            button[i] = new JButton(Integer.toString(Game.populated[i]));
            // display the buttons without text
            button[i] = new JButton("");

            // set the button size so it is square
            button[i].setPreferredSize(new Dimension(50, 50));

            // Make sure the button triggers an event
            button[i].addActionListener(this);
            // and that the event has a specific id (the button number)
            button[i].setActionCommand(Integer.toString(i));
            // Add the button to the grid.
            pane.add(button[i]);
            // paint on every pixel of the button
            button[i].setOpaque(true);

            // for testing purposes
            // green outline for buttons that contains ships
            if (Game.populated[i] == 1){
                button[i].setBackground(Color.green);
                button[i].setOpaque(true);
            }
        }
    }

    // The actioned performed when the event is triggered
    // In other words when the button is clicked
    public void actionPerformed(ActionEvent e) {
        // The action command contains the number of the button
        // but it is held as a string
        String cmd = e.getActionCommand();
        // so we convert to an integer
        int x = Integer.parseInt(cmd);
        // if the button clicked populated value is 1
        if(Game.populated[x] == 1){
            // use these button properties
            Board.button[x].setText("X");
            Board.button[x].setBackground(Color.RED);
            Board.button[x].setOpaque(true);
            Board.button[x].setEnabled(false);
            win++;
        } else {
            // if the button clicked populated value is 0
            // use these button properties
            Board.button[x].setText("");
            Board.button[x].setBackground(Color.BLUE);
            Board.button[x].setOpaque(true);
            Board.button[x].setEnabled(false);
            // reduce life for every miss
            Game.life--;
        }
        if (win == 17){
            // display win status
            JOptionPane.showMessageDialog(null, "You win");
            System.exit(0);
        }
    }
}
