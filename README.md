### Things to do before running the script:
- Verify the JMeter test plan has the correct user defined variables, csv input data file.
- Check runJMeter.bat has the right directory location of the JMeter application as well the the JMeter script, input data, etc.
- Copy the attached JMeter property file(*user.properties*) in the JMeter bin directory, i.e.```<JMETER_HOME>\apache-jmeter-5.5\bin```


### To run the test from CLI(non-GUI mode):
>*check runTests.bat for test scenarios*
```
C:\infratest>runTests.bat t 2 1 1
where:  

%1 or t - test mode
%2 - vuser count
%3 - ramp-up rate
%4 - loop count
```

This template uses the JMeter controller Thread Group for simplicity. To use other types of controllers, i.e. Arrivals Thread Group, you can do so by locally modifying the script and the .bat files to run via CLI/shell.

You could also run something like the below commands directly on the CLI instead of using the batch files:
```
SETLOCAL
SET d=%DATE:~-4%-%DATE:~7,2%-%DATE:~4,2%
SET t=%time::=.% 
SET t=%t: =%
SET timeStamp=%d%_%t%
SET JMETER_Dir=C:\Utils\apache-jmeter-5.5\bin\jmeter
SET Source_Dir=C:\infratest
SET TestName=MyApp_TestPlan

%JMETER_Dir% -n -t %Source_Dir%\testPlan\%TestName%.jmx -j %Source_Dir%\testReport\run-log-%TestName%_%timeStamp%.log -l %Source_Dir%\testReport\report-out\perfRunLog-%TestName%_%timeStamp%.jtl -e -o %Source_Dir%\testReport\report-out\%TestName%_%timeStamp%
```

### Test Report
- The script will generate a report summary in html format provided you copied ```user.properties`` in the JMeter bin directory prior executing the test.
  
- A test report metadata in JTL and JSON format will also be generated. You could use the JTL file to create a JMeter report in graphical or table view.
  
- APDEX satisfaction and tolerance thresholds are set to 500 ms and 1500 ms, respectively.
  Update ```user.properties`` to change these.
    ```
       #jmeter.reportgenerator.apdex_satisfied_threshold=500

       #jmeter.reportgenerator.apdex_tolerated_threshold=1500
    ```   

### Monitor test performance in real-time with Azure AppInsights
If you haven't done so, create an Application Insights instance in Azure and take note of its 'Connection String' key. Next, install Azure backend listener in JMeter. Add a backend listener in the JMeter Test Plan and choose AzureBackendClient implementation. On the parameters section, add a descriptive name and populate the 'Connection String'.

When you start the test, head over to the Azure AppInsights dashboard to visualise test results metrics. Data such as 'Failed Requests', 'Server Response Time', 'Server Requests' are displayed in real-time. You could also create custom charts using KQL query.


### Gotchas
- 'Out of Memory' issue workarounds:
  - Always run JMeter in non-GUI(CLI) mode unless on-development or debugging. 
    - JMeter GUI tends to consume loads of resources.
  - Disable all listeners during test run.
    - Open the .jtl results file with any listener after the test completes.
  - Increase the maximum heap size to ~80% of the total available physical RAM of the client environment.
    - Modify ```<JMETER_HOME>\apache-jmeter-5.5\bin\setenv.bat``` and restart JMeter to apply the change.
    ```
    //To set the max heap size to 4Gigs
    set HEAP=-Xms1g -Xmx4g
    ```


### [TODO] Run JMeter in Distributed Mode

### [TODO] Run JMeter Tests in Azure Pipeline
