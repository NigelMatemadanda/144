package Game_Battleships;

import javax.swing.*;
import java.util.Random;

public class Game {
    public static Ship[] ship = new Ship[6];
    public static int[] populated = new int[100];
    public static int[] collision = new int[100];
    public static int numCollision = 0;
    public static int life;
    Random random = new Random();

    public Game() {
        // call the setup ship method
        setupShip();

    }
    private void setupShip(){
        // create ship instances
        ship[0] = new Ship();
        ship[1] = new Ship();
        ship[2] = new Ship();
        ship[3] = new Ship();
        ship[4] = new Ship();
        ship[5] = new Ship();
        // set the length of the ships
        ship[0].setLength(4);
        ship[1].setLength(3);
        ship[2].setLength(3);
        ship[3].setLength(2);
        ship[4].setLength(2);
        ship[5].setLength(2);

        // set the orientation of the ships
        for(int i = 0; i <6; i++){
            // generate a random number in the range 0 to 1
            ship[i].setOrientation(getRandomInteger(0,1));
            // place the ship on the grid while
            placeShip(i);

            // if the ship is horizontal
            if (ship[i].getOrientation() == 0){
                for(int j = ship[i].getStart(); j < ship[i].getStart()+ship[i].getLength(); j++){
                    populated[j] = 1;
                }
            }else{ // if the ship is vertical
                for(int j= ship[i].getStart(); j < ship[i].getStart()+ (ship[i].getLength() *10); j +=10){
                    populated[j] = 1;
                }
            }
        }
    }
    // place ship method
    public void placeShip(int shipID){
        do {
            // check if the position can be used to place a ship
            if (ship[shipID].getOrientation() ==0){
                // set the length to a variable l
                int l = ship[shipID].getLength();
                int x;
                do { // select a random position on the grid
                    x = getRandomInteger(0,99);
                    // if the ship does not go out of bounds horizontally
                    // place it
                }while (x % 10 > (10 - l));
                ship[shipID].setStart(x);
            }else { // if the ship does not go out of bounds vertically
                ship[shipID].setStart(getRandomInteger (0, (99 - (10 * ship[shipID].getLength()-1))));
            }
        }while (!checkCollision(shipID));
    }
    // check if the ship collides with other ships
    public boolean checkCollision(int shipID){
        if (shipID != 0){
            // if ship is horizontal
            if (ship[shipID].getOrientation()== 0){
                for (int i = ship[shipID].getStart(); i < ship[shipID].getStart() + ship[shipID].getLength(); i++){
                    // if the position is occupied
                    if (collision[i] != 0){
                        numCollision++;
                        return false;
                    }
                }
            } else { // ship is vertical
                for(int i = ship[shipID].getStart(); i < ship[shipID].getStart() + (ship[shipID].getLength() * 10); i += 10){
                    if (collision[i] != 0){
                        numCollision++;
                        return false;
                    }
                }
            }
            // add ship to collision array
        }addShipToCollisionArray(shipID);
        return true;
    }
    // add ship to collision array
    public void addShipToCollisionArray(int shipID){
        int startPoint = ship[shipID].getStart();
        int endPoint;

        if (ship[shipID].getOrientation()==0){
            // if ship is horizontal the end point is start point plus ship length minus 1
            endPoint = startPoint + ship[shipID].getLength()-1;
        } else { // if ship is vertical
            // end point is start point plus ship length minus one multiplied by 10
            endPoint = startPoint+ ((ship[shipID].getLength()-1)*10);
        }
        startPoint -=11;
        endPoint += 11;

        if (startPoint < 0){
            startPoint +=11;
        }
        if (startPoint % 10 == 9){
            startPoint +=1;
        }
        if (endPoint > 99){
            endPoint -=10;
        }

        if (endPoint % 10 == 0){
            endPoint -=1;
        }
        // add points that overlap to the collision array
        for(int row = startPoint / 10; row <= endPoint / 10; row++){
            for (int col = startPoint % 10; col <= endPoint % 10; col++){
                int cell = (row * 10) + col;
                if (cell >= 0 && cell < 100){
                    collision[cell] = 1;
                }
            }
        }
    }
    // method to generate random numbers between two integers
    public int getRandomInteger(int start, int end){
        return start + random.nextInt(end - start + 1);
    }
    // main method to run the game
    public static void main(String[] args) {
        // create an instance of the game
        Game playGame = new Game();
        int rows = 10;
        int cols = 10;

        // create an instance of the game board
        Board gt = new Board(rows, cols);
        gt.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        gt.pack();
        gt.setVisible(true);

    }

}
