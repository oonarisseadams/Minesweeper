mport de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int row = 0; row < NUM_ROWS; row++)
    {
      for(int col = 0; col < NUM_COLS; col++)
      {
        buttons[row][col] = new MSButton(row,col);
      }
    }
    for(int i = 0; i < 25; i++)
      setBombs();
}
public void setBombs()
{
  for(int i = 0; i < 2; i++)
  {
    int r = (int)(Math.random()*NUM_ROWS);
    int c = (int)(Math.random()*NUM_COLS);
    if(!bombs.contains(buttons[r][c]))
            bombs.add(buttons[r][c]);
     System.out.println(r + "," + c);
  }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
        
     for(int i = 0; i < NUM_ROWS; i++)
       for(int j = 0; j < NUM_COLS; j++)
         buttons[i][j].draw();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
    for(int i = 0; i < bombs.size(); i++)
        if(bombs.get(i).isClicked() == false)
          bombs.get(i).mousePressed();
    //fill(255);
    //for(int r = 0; r < NUM_ROWS; r++)
    //    for(int c = 0; c < NUM_COLS; c++)
    //    {
    //        buttons[r][c].setLabel("");
    //    }
    buttons[4][1].setLabel("Y");
    buttons[4][2].setLabel("O");
    buttons[4][3].setLabel("U");
    buttons[4][5].setLabel("L");
    buttons[4][6].setLabel("O");
    buttons[4][7].setLabel("S");
    buttons[4][8].setLabel("E");
}
public void displayWinningMessage()
{
    background(90, 255, 0);
    textAlign(CENTER);
    text("You Win", 200, 200);
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(keyPressed == true || mousePressed && (mouseButton == RIGHT))
        {
            if(marked == false)
            {
                marked = true;
            }
            else if(marked == true)
            {
                clicked = false;
                marked = false;
            }
        }
            else if(bombs.contains(this))
            {
                displayLosingMessage();
            }
            else if(countBombs(r,c) > 0)
            {
                setLabel("" + countBombs(r,c));
            }
            else{

                if(isValid(r+1,c) && !buttons[r+1][c].isClicked())
                    buttons[r+1][c].mousePressed();

                if(isValid(r-1,c) && !buttons[r-1][c].isClicked())
                    buttons[r-1][c].mousePressed();

                if(isValid(r,c+1) && !buttons[r][c+1].isClicked())
                    buttons[r][c+1].mousePressed();

                if(isValid(r,c-1) && !buttons[r][c-1].isClicked())
                    buttons[r][c-1].mousePressed();

                if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked())
                    buttons[r+1][c+1].mousePressed();

                if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked())
                    buttons[r+1][c-1].mousePressed();

                if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked())
                    buttons[r-1][c-1].mousePressed();

                if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked())
                    buttons[r-1][c+1].mousePressed();
            }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if( r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
          return true;
        else
          return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
                if(isValid(row-1, col-1))
        {
            if(bombs.contains(buttons[row-1][col-1]))
                numBombs++;
        }
        if(isValid(row-1, col))
        {
            if(bombs.contains(buttons[row-1][col]))
                numBombs++;
        }
        if(isValid(row-1, col+1))
        {
            if(bombs.contains(buttons[row-1][col+1]))
                numBombs++;
        }
        if(isValid(row, col-1))
        {
            if(bombs.contains(buttons[row][col-1]))
                numBombs++;
        }
        if(isValid(row, col+1))
        {
            if(bombs.contains(buttons[row][col+1]))
                numBombs++;
        }
        if(isValid(row+1, col-1))
        {
            if(bombs.contains(buttons[row+1][col-1]))
                numBombs++;
        }
        if(isValid(row+1, col))
        {
            if(bombs.contains(buttons[row+1][col]))
                numBombs++;
        }
        if(isValid(row+1, col+1))
        {
            if(bombs.contains(buttons[row+1][col+1]))
                numBombs++;
        }
        return numBombs;
    }
}

