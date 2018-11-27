SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE   FUNCTION [dbo].[ProperCase] (@String VARCHAR(1000))
RETURNS VARCHAR(1000)
AS
BEGIN
DECLARE @TempString VARCHAR(1000)
DECLARE @PS VARCHAR(1000)
SET @PS = ''
-- lower case entire string
SET @TempString = LOWER(@String)
WHILE CHARINDEX(' ',@TempString) > 0
BEGIN
  -- Check to see if first character of @TempString is whitespace
  IF (SUBSTRING(@TempString,1,1) = ' ')
  BEGIN
    SET @PS = @PS + SUBSTRING(@TempString,1,1)
  END
  ELSE -- @TempString starts with a Name
  BEGIN
    -- upper case first character and return string up to the next space
    SET @PS = @PS + UPPER(SUBSTRING(@TempString,1,1)) + SUBSTRING(@TempString,2,CHARINDEX(' ',@TempString)-1)
    
  END
  -- truncation string that we have already processed
  SET @TempString = SUBSTRING(@TempString,CHARINDEX(' ',@TempString)+1,LEN(@TempString))
END
-- proper case last word/name
SET @PS = @PS + UPPER(SUBSTRING(@TempString,1,1)) + SUBSTRING(@TempString,2,LEN(@TempString))
RETURN (@PS)
END




GO
