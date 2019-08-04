# Import libraries
import glob
import json
import os
import sys

###################################################################################################
def json2timeline(files, case, np, timer):
    '''
    Extract dates and wall-clock times (s) from ctest.json files
    '''
    dates = []
    wtimes = []
    for file in files:
        # Load ctest data
        with open(file) as jf:
            ctestData = json.load(jf)

        # Organize data for strong scaling plots
        for ctest in ctestData.values():
            if ctest['case'] == case and ctest['np'] == np:
                dates.append(ctest['date'])
                if timer in ctest['timers']:
                    wtimes.append(ctest['timers'][timer])

    # Sort based on dates
    dates, wtimes = zip(*sorted(zip(dates, wtimes)))

    return dates, wtimes

###################################################################################################
if __name__ == "__main__":
    '''
    Example: Load dummy json and test extraction of timeline data
    '''
    # Pass directory name
    if len(sys.argv) < 2:
        dir = ''
    else:
        dir = sys.argv[1]

    # Extract file names
    files = glob.glob(os.path.join(dir,'ctest-*'))

    # Specify case to extract from ctest.json file
    cases = ('R0','R1')

    # Specify number of processes to extract from ctest.json file
    nps = {'R0': (48, 96, 192, 384), 'R1': (384, 768)}

    # Specify timers to extract from ctest.json file (note: must be unique names per test in file)
    timers = ('panzer::ModelEvaluator::evalModel(J):',
              'Stratimikos: BelosLOWS:',
              'GMRES block system: Operation Prec*x:',
              'CG S_E: BlockCGSolMgr total solve time:')

    # Loop over cases for this example
    for case in cases:
        for np in nps[case]:
            for timer in timers:
                # Extract info and print
                dates, wtimes = json2timeline(files, case, np, timer)
                print(dates,wtimes)

