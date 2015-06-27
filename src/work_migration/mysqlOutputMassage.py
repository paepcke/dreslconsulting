'''
Created on Jun 19, 2015

@author: paepcke

Prepare a state migration export from MySQL for display
as chord chart by Circos software.

Takes a file of the form 
   FromState\tToState\tNumMigrations,
with lines such as:

    AK    IL    3

Outputs to stdout a matrix of the form:

    State,    <state1>,<state2>,<state3>,...
    <state1>     10,     30,....
    <state2>
    <state3>
    
Mandatory argument is the input file. Optional argument
is the minimum number of migrations between states that
are considered. Too low a number makes the chart too 
crowded. Default is 3;     

Ones the output of this script is in <state/stateMatrix>.csv,
Circos charts are produced on the command line as follows:

    * cd <circosRoot>/tools/tableviewer
    * Get table into circos-digestible shape:
        cat <state/stateMatrix>.csv  | bin/parse-table -field_delim ,  -no-field_delim_collapse | bin/make-conf -dir data

    * Create the image:
        ../../bin/circos -conf etc/circos.conf
  
    * View the image using Eye of Gnome:
      eog img/tableview.png 

'''
from collections import OrderedDict
import sys


class MySQLOutputMassager(object):
    '''
    classdocs
    '''

    MINIMUM_MIGRATION = 3
    STATES = "AL,AK,AZ,AR,CA,CO,CT,DE,FL,GA,HI,ID,IL,IN,IA,KS,KY,LA,ME,MD,MA,MI,MN,MS,MO,MT,NE,NV,NH,NJ,NM,NY,NC,ND,OH,OK,OR,PA,RI,SC,SD,TN,TX,UT,VT,VA,WA,WV,WI"
    
    def __init__(self, w1W2NumMovesTsvFile):
        '''
        Constructor
        '''
        
        # Make an array of alphabetized states:
        self.statesArr = sorted(MySQLOutputMassager.STATES.split(',')) 
        
        self.w1Dict = OrderedDict()
        for oneState in self.statesArr:
            # Throw out unknown state abbreviations:
            if oneState not in MySQLOutputMassager.STATES:
                continue
            
            # For each state, create a key in
            # statesArr of the state's name, and
            # init its value to an empty dict, which
            # will hold the w2 destination state dict:
            w2Dict = OrderedDict()
            
            # Init the w2 dict with 0s (people who
            # did their next job in each of the 
            # states):
            for w2State in self.statesArr:
                w2Dict[w2State] = '0'
                
            self.w1Dict[oneState] = w2Dict 
             
        self.massageOutput(w1W2NumMovesTsvFile)
        
    def massageOutput(self, w1w2NumMovesTsvFile):
        '''
        Get:
         
        "AB"    "NY"    10
		"AK"    "PR"    20
		"AK"    "VI"    30
		"AL"    "AL"    40
		      ...

		Where 1st col is State of first work,
		2nd col is State of second work.
		
		Print to stdout:
		
		Data AB     AK     AL ... NY  ... PR  ... VI
		AB   -,-,-,10,-,-
		AK   -,-,-,-,20,30
        AL   -,-,40,-,-,-		
        
        :param w1w2NumMovesTsvFile:
        :type w1w2NumMovesTsvFile:
        '''
        
        with open(w1w2NumMovesTsvFile, 'r') as fd:
            for row in fd:
                rowArr = row.split('\t')
                w1State  = rowArr[0].strip('"')
                w2State  = rowArr[1].strip('"')
                numMoves = rowArr[2].strip()
                
                # Make sure data is clean:
                if w1State not in MySQLOutputMassager.STATES or \
                    w2State not in MySQLOutputMassager.STATES:
                    continue
                try:
                    numMoves = int(numMoves)
                except TypeError:
                    # Skip this input row
                    continue

                try:
                    w2Dict = self.w1Dict[w1State]
                except KeyError:
                    # Bad state abbreviation in file; ignore it:
                    continue

                w2Dict[w2State] = numMoves
                    
                    
        #print(self.w1Dict)
        # Create the matrix and write to stdout.
        
        # Remove row/column pairs in which no entry is
        # > 0:
        relevantStates = self.thinOutMatrix()
        if len(relevantStates) == 0:
            sys.stdout.write('No migration larger than the minimum of %s' % MySQLOutputMassager.MINIMUM_MIGRATION)
            sys.exit()
        
         
        sys.stdout.write('States,' + ','.join(relevantStates))
        
        for nextRelevantState in relevantStates:
            sys.stdout.write('\n')
            # Fill one row in the 50x50 matrix:
            sys.stdout.write(nextRelevantState + ',')
            nextRelevantStateW2DestDict = self.w1Dict[nextRelevantState]
            lastDestState = relevantStates[-1]
            for destStateKey in relevantStates:
                if destStateKey == lastDestState:
                    sys.stdout.write(str(nextRelevantStateW2DestDict[destStateKey]))
                else:
                    sys.stdout.write(str(nextRelevantStateW2DestDict[destStateKey]) + ',')
        sys.stdout.write('\n')
            
    def thinOutMatrix(self):
        
        relevantStates = []
        for fromState in self.statesArr:
            destStatesDict = self.w1Dict[fromState]
            for (toState, toMigration) in destStatesDict.items():
                if int(toMigration) > MySQLOutputMassager.MINIMUM_MIGRATION:
                    if toState not in relevantStates:
                        relevantStates.append(toState)
                    break
        return relevantStates
                
            
                
if __name__ == '__main__':
    
    if len(sys.argv) < 2:
        print('Usage: mysqlOutputMassage <w1w2CountTsv> [minMigration]')
        sys.exit()
    inputTable = sys.argv[1]
    if len(sys.argv) > 2:
        MySQLOutputMassager.MINIMUM_MIGRATION = sys.argv[2]
        
    MySQLOutputMassager(inputTable)
                    