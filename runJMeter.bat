:: =================================================================
:: JMeter Non GUI mode command options
:: https://jmeter.apache.org/usermanual/get-started.html#non_gui
::
:: -n
:: This specifies JMeter is to run in cli mode
:: -t
:: [name of JMX file that contains the Test Plan].
:: -l
:: [name of JTL file to log sample results to].
:: -j
:: [name of JMeter run log file].
:: -r
:: Run the test in the servers specified by the JMeter property "remote_hosts"
:: -R
:: [list of remote servers] Run the test in the specified remote servers
:: -g
:: [path to CSV file] generate report dashboard only
:: -e
:: generate report dashboard after load test
:: -o
:: output folder where to generate the report dashboard after load test. Folder must not exist or be empty
:: The script also lets you specify the optional firewall/proxy server information:
:: 
:: -H
:: [proxy server hostname or ip address]
:: -P
:: [proxy server port]

:: Set timeStamp
SETLOCAL
SET d=%DATE:~-4%-%DATE:~7,2%-%DATE:~4,2%
SET t=%time::=.% 
SET t=%t: =%
SET timeStamp=%d%_%t%

:: Fetch param
SET "test=%1"
SET "vuser=%2"
SET "rampup=%3"
SET "loop=%4"

SET appServer=MyApp_local

SET jmeter=C:\..\apache-jmeter-5.5\bin\jmeter
SET testFolder=C:\..\infratest

SET testName=MyApp_TestPlan
REM SET testName=AccountsPayable
SET testPlan=%testFolder%\testPlan\%testName%.jmx

SET reportFolder=%testName%_%timeStamp%
SET reportOut=testReport\report-out
SET outputFolder=%testFolder%\%reportOut%\%reportFolder%
SET runLog=%testFolder%\%reportOut%\run-log-%reportFolder%.log
SET sampleLog=%outputFolder%\perfRunLog-%reportFolder%.jtl

ECHO ON

%jmeter% -n -t %testPlan% -j %runLog% -l %sampleLog% -e -o %outputFolder% -Jvuser=%vuser% -Jrampup=%rampup% -JloopCount=%loop%