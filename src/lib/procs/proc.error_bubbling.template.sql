CREATE OR REPLACE PROCEDURE {{PROC_NAME}}({{PROC_PARAMETERS}}) 
RETURNS {{PROC_RETURN_TYPE}} 
LANGUAGE JAVASCRIPT 
AS 
$$ 
  
  {{PROC_BODY}} 

$$;