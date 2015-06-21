'''
Created on Jun 19, 2015

@author: paepcke
'''
from collections import OrderedDict
import sys


class MySQLOutputMassager(object):
    '''
    classdocs
    '''

    STATES = "AL\tAK\tAZ\tAR\tCA\tCO\tCT\tDE\tFL\tGA\tHI\tID\tIL\tIN\tIA\tKS\tKY\tLA\tME\tMD\tMA\tMI\tMN\tMS\tMO\tMT\tNE\tNV\tNH\tNJ\tNM\tNY\tNC\tND\tOH\tOK\tOR\tPA\tRI\tSC\tSD\tTN\tTX\tUT\tVT\tVA\tWA\tWV\tWI"
    
    def __init__(self, w1W2NumMovesTsvFile):
        '''
        Constructor
        '''
        
        # Make an array of alphabetized states:
        self.statesArr = MySQLOutputMassager.STATES.split('\t') 
        
        self.w1Dict = OrderedDict()
        for oneState in self.statesArr:
            # For each state, create a key in
            # statesArr that is the state, and
            # init its value to an empty dict, which
            # will hold the w2 destination state:
            w2Dict = OrderedDict()
            
            # Init the w2 dict with 0s (people who
            # did their 2nd job in each of the 
            # states:
            for w2State in self.statesArr:
                w2Dict[w2State] = 0
                
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
		
		     AB     AK     AL ... NY  ... PR  ... VI
		AB   0      0      0      10      0        0
		AK   0      0      0       0     20       30
        AL   0      0     40       0      0        0		
        
        :param w1w2NumMovesTsvFile:
        :type w1w2NumMovesTsvFile:
        '''
        
        with open(w1w2NumMovesTsvFile, 'r') as fd:
            for row in fd:
                rowArr = row.split('\t')
                w1State  = rowArr[0].strip('"')
                w2State  = rowArr[1].strip('"')
                numMoves = rowArr[2].strip()
                try:
                    w2Dict = self.w1Dict[w1State]
                except KeyError:
                    # Bad state abbreviation in file; ignore it:
                    continue

                w2Dict[w2State] = numMoves
                    
                    
        #print(self.w1Dict)
        # Create the matrix and write to stdout:
        sys.stdout.write('States\t' + MySQLOutputMassager.STATES)
        
        for nextAlphaState in self.statesArr:
            sys.stdout.write('\n')
            # Fill one row in the 50x50 matrix:
            sys.stdout.write(nextAlphaState + '\t')
            nextAlphaStateW2DestDict = self.w1Dict[nextAlphaState]
            for destStateKey in nextAlphaStateW2DestDict.keys():
                sys.stdout.write(str(nextAlphaStateW2DestDict[destStateKey]) + '\t')
            
            
                
if __name__ == '__main__':
    
    if len(sys.argv) != 2:
        print('Usage: mysqlOutputMassage <w1w2CountTsv>')
        sys.exit()
        
    MySQLOutputMassager(sys.argv[1])
                    