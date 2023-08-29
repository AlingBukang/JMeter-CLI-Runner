@ECHO OFF

:: test run scenarios
IF "%1" == "t" (
	SET Test=Testing
	SET vuser=%2
	SET rampup=%3
	SET loop=%4
) ELSE IF "%1" == "b" (
	SET Test=Baseline
	SET vuser=1
	SET rampup=0
	SET loop=1	
) ELSE IF "%1" == "n" (
	SET Test=normalLoad
	SET vuser=10
	SET rampup=2
	SET loop=1
) ELSE IF "%1" == "p" (
	SET Test=peakLoad
	SET vuser=10
	SET rampup=3
	SET loop=10
) ELSE (
	ECHO arg must be b for Baseline, or n for normalLoad, or p for peakLoad, or t for testing.
	GOTO:eof
)

setlocal ENABLEDELAYEDEXPANSION


ECHO ----------------

ECHO Run test with:
ECHO  - Test = %Test%
ECHO  - vuser = %vuser%
ECHO  - rampup = %rampup%
ECHO  - loop = %loop%

CALL runJMeter.bat %Test% %vuser% %rampup% %loop%

@ECHO OFF


PAUSE