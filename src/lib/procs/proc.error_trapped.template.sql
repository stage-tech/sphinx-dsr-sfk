CREATE OR REPLACE PROCEDURE {{PROC_NAME}}({{PROC_PARAMETERS}}) 
RETURNS {{PROC_RETURN_TYPE}} 
LANGUAGE JAVASCRIPT 
AS 
$$ 
const states = { STARTING: "STARTING", RUNNING: "RUNNING", COMPLETED: "COMPLETED", ERROR: "ERROR",   ALREADY_RUNNING: "ALREADY_RUNNING" };
const messageTypes = { ERROR_CODE: "ERROR_CODE", ERROR_MESSAGE: "ERROR_MESSAGE", ERROR_STACK_TRACE: "ERROR_STACK_TRACE", COMPLETION_CODE : "COMPLETION_CODE " };
var executionResult = { messages : [] };
function createInitialState(processId) { executionResult.processId = processId; };

function createErrorState(type, message, args) { 
  executionResult.state = states.ERROR;
  var errorMessage = { type, message };
  if (args) {
    errorMessage.args = args;
  }
  executionResult.messages.push(errorMessage);
};

function createErrorStateFromException(err) { 
  executionResult.state = states.ERROR;
  executionResult.messages.push( {
    type : messageTypes.ERROR_CODE , message : err.code
  });
  executionResult.messages.push( {
    type : messageTypes.ERROR_MESSAGE , message : err.message
  });
  executionResult.messages.push( {
    type : messageTypes.ERROR_STACK_TRACE , message : err.stackTraceTxt
  });
};
function createCompletionState() { executionResult.state = states.COMPLETED; };

 try { 
   if(!PROCESS_ID){
     PROCESS_ID = ''
   }
   createInitialState(PROCESS_ID);

  {{PROC_BODY}}

  if (executionResult.state !== states.ERROR) {
    createCompletionState(); 
  }
} catch (err) { 
    createErrorStateFromException(err)
} 

return JSON.stringify(executionResult);
$$;