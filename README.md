### Blood Pressure Logger (BPL)

A very simple gem to help you track your [blood pressure](http://en.wikipedia.org/wiki/Blood_pressure) values over time. With BPL you can also:

  - export your data to other applications; Numbers, Excel, etc.
  - view history for a given period of time
  - and more
  
Your privacy is very important, this is why the BPL application is open source and it is using only local resources such as the small database stored on your computer. A basic guarantee that your data is safe and completely under your own control.

## Installation

Install the BP gem:

    $ gem install bpl

Create a new folder `.bp` in your home directory:

    $ mkdir ~/.bp
    

## Usage

You'll have to initialize the database first, this is a one-time command:

    $ bpl init

After that you can start recording your BP measurements as needed. Examples:

    $ bpl 145/81/67/L/87 -d 2012/12/10 -t 16:30 -m notes
    $ bpl 136/60/66
    $ bpl 136/60/66/r
    $ bpl 125/71/67/L/87 -d 2012/12/11 -m "some notes" 
    $ bpl 136/60/66/l/85
    $ bpl 120/64/67/L/87 -D "2012/12/10 16:30" 

BPL expects you to enter the following values:
  
    SYS/DIA/HR/ARM/WEIGHT

Where:
    
    SYS: systolic pressure.
    DIA: diastolic pressure.
    HR: heart rate 
    ARM: 'l' or 'r'. Left or right. It is optional; LEFT arm, if not specified.
    WEIGHT: weight (optional, see note below)

You can also specify the date, date and time, and an optional comment, as seen in the previous set of examples.
    
A special **note** to remember when you log your data. Your weight is important but you're not required to specify it every time you add a new measurement. Specify your weight at least once or very time it is changing. The last weight value will be reused when not specified explicitly in the measurement.

### Other useful commands
A handful of command lines and switches are provided for your convenience.

**View**  
- display a page with the most recent records, or recorded at a specified date/time. Example:

    $ bpl view
    $ bpl view -d 2012/08/01
    $ bpl view -d 08/14 -t 09:31:10

**Remove**  
delete a record by record id. The record id can be observed with the **view** command. Example:

    $ bpl view -d 08/14 -t 09:31:10
    +--+-------------------+---+---+--+-----+------+-----+
    |Id|       Date        |Sys|Dia|Hr| Arm |Weight|Notes|
    +--+-------------------+---+---+--+-----+------+-----+
    |2 |2012-09-25 09:31:11|120|80 |67|LEFT |90    |     |
    |1 |2012-09-25 09:30:30|1  |2  |3 |RIGHT|90    |     |
    +--+-------------------+---+---+--+-----+------+-----+

    $ bpl remove 1
    record: #1, was removed.

**Export to CSV**  
export your data to a file that can be imported by other applications, including Numbers or Excel. 

Here is an example exporting the data to the screen:

    $ bpl export -d 9/14  
    ID,DATE,SYS,DIA,HR,ARM,WEIGHT,NOTES
    2,'2012-09-25 09:31:11',120,80,67,'LEFT',90,''

And to a specified file:

    $ bpl export -d 2012/08/01 -f > my_bp.csv
    $
  
**Init**  
use init with `-f` if you want to wipe out clean your local database. Warning, your data cannot be restored after this point in time. Example:
  
    $ bpl init -f

**Help**

    $ bpl -h

    Simple blood pressure logger

    Available commands: history, series, delete, view, init, plot

    Examples:

       $ bpl 145/81/67/L/87 -d 2012/12/10 -t 16:30 -m notes
       $ bpl 136/60/66
       $ bpl 136/60/66/r
       $ bpl 125/71/67/L/87 -d 2012/12/11 -m "some notes" 
       $ bpl 136/60/66/l/85
       $ bpl 120/64/67/L/87 -D "2012/12/10 16:30" 
       $ bpl export -d 2012/08/01 -f > my_bp.csv

    The following options apply:
        --date, -d <s>:   Date (default: 2012/10/31)
        --time, -t <s>:   Time (default: 11:01:31)
    --datetime, -D <s>:   Specify the date and the time, surrounded with quotes ";
     --message, -m <s>:   Notes, comments
           --force, -f:   Force database initialization, all the data will be lost
             --raw, -r:   used to view the data without formatting
        --page, -p <i>:   total number of records to view (default: 15)
             --all, -a:   export the entire dataset, all the records
           --quiet, -q:   no echoing to console
            --help, -h:   Show this message
      

### TODO

  - plot the data for simple visualizations

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License
MIT, please see the attached LICENSE.txt for more details.
