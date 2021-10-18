CREATE OR REPLACE DATABASE %ENV%_DDEX_DSR;

use database %ENV%_DDEX_DSR;

CREATE OR REPLACE SCHEMA STAGING;

USE SCHEMA STAGING;

CREATE OR REPLACE TABLE INGEST_CONFIG (
  SOURCE VARCHAR,
  SCHEMA_VERSION VARCHAR,
  SCHEMA VARCHAR,
  FUNCTION VARCHAR
);

CREATE OR REPLACE TABLE FLAT_FILE (
  ASSET_ID VARCHAR,
  LINE_INDEX INTEGER,
  LINE VARCHAR
);

CREATE OR REPLACE FILE FORMAT FLAT_FILE_UTF8
COMPRESSION = 'AUTO'
FIELD_DELIMITER = 'NONE'
RECORD_DELIMITER = '\n'
SKIP_HEADER = 0
FIELD_OPTIONALLY_ENCLOSED_BY = 'NONE'
TRIM_SPACE = FALSE
ERROR_ON_COLUMN_COUNT_MISMATCH = TRUE
ESCAPE = 'NONE'
ESCAPE_UNENCLOSED_FIELD = 'NONE'
DATE_FORMAT = 'AUTO'
TIMESTAMP_FORMAT = 'AUTO'
NULL_IF = ('\\N');


/*
Amazon is following the DDEX DSR Architecture V1.1 escape handling
Tab escaping is not enabled from the looks of it
Pipe escaping seems to be at times either 2 or 1 backslashes
Backslash replacement needs to be done after pipe escaping
I have a feeling they may be using some form of CSV Handler to build this possibly
and is why the backslash handling has to happen at the end
 */
CREATE OR REPLACE FUNCTION DDEX_DSR_PARSER_AMAZON(LINE VARCHAR)
RETURNS ARRAY
LANGUAGE JAVASCRIPT
AS $$
const TAB = '\t';
const PIPE = '|';
const BACKSLASH = '\u005C';
const TAB_ESCAPE = '\u005C';
const PIPE_ESCAPES = ['\u005C\u005C', '\u005C'];
const DDEX_BACKSLASH = '\u005C\u005C';

function simpleMerge(value, escapes, replacement) {
    if (value.length <= 1) {
        return value;
    }
    var result = [];
    for (let i = 0; i < value.length; i++) {
        if (result.length == 0) {
            result.push(value[i]);
        } else {
            var foundEscape = false;
            const last = result.pop();
            for (let j = 0; j < escapes.length && !foundEscape; j++) {
                if (last.endsWith(escapes[j])) {
                    result.push(last.substr(0, last.length - escapes[j].length) + replacement + value[i]);
                    foundEscape = true;
                }
            }
            if (!foundEscape) {
                result.push(last, value[i]);
}
        }
    }
    return result;
}

function cleanup(value) {
    return value.map(v => {
        const cells = v.map(c => c.length == 0 ? null : c)
        return cells.length == 1 && cells[0] == null ? [] : cells;
    })
}

const data = cleanup(LINE.split(TAB).map(a =>
        simpleMerge(a.split(PIPE), PIPE_ESCAPES, PIPE).map(b =>
            b.split(DDEX_BACKSLASH).join(BACKSLASH))
    ))

return data;
$$;

/*
Youtube is following the DDEX DSR Architecture V1.2+ for escape handling
Even though the MessageVersion says they are using Architecture V1.1
This seems to be done in a more stream based processing approach from youtube
so we need to change the ordering of when we split and merge the data back together
*/
CREATE OR REPLACE FUNCTION DDEX_DSR_PARSER_YOUTUBE(LINE VARCHAR)
RETURNS ARRAY
LANGUAGE JAVASCRIPT
AS $$
const TAB = '\t';
const PIPE = '|';
const BACKSLASH = '\u005C';
const TAB_ESCAPES = ['\u005C'];
const PIPE_ESCAPES = ['\u005C\u005C', '\u005C'];
const DDEX_BACKSLASH = '\u005C\u005C\u005C';

function simpleMerge(value, escapes, replacement) {
    if (value.length <= 1) {
        return value;
    }
    var result = [];
    for (let i = 0; i < value.length; i++) {
        if (result.length == 0) {
            result.push(value[i]);
        } else {
            var foundEscape = false;
            const last = result.pop();
            for (let j = 0; j < escapes.length && !foundEscape; j++) {
                if (last.endsWith(escapes[j])) {
                    result.push(last.substr(0, last.length - escapes[j].length) + replacement + value[i]);
                    foundEscape = true;
                }
            }
            if (!foundEscape) {
                result.push(last, value[i]);
            }
        }
    }
    return result;
}

function backslashMerge(value) {
    var result = [];
    for (let i = 0; i < value.length; i++) {
        if (result.length == 0) {
            result.push(...value[i]);
        } else {
            const last = result[result.length - 1].pop();
            const mergedItem = last + BACKSLASH + value[i][0][0];
            result[result.length - 1].push(mergedItem, ...value[i][0].slice(1))
            result.push(...value[i].slice(1))
        }
    }
    return result;
}

function cleanup(value) {
    return value.map(v => {
        const cells = v.map(c => c.length == 0 ? null : c)
        return cells.length == 1 && cells[0] == null ? [] : cells;
    })
}

const data = cleanup(
    backslashMerge(LINE.split(DDEX_BACKSLASH)
        .map(a => simpleMerge(a.split(TAB), TAB_ESCAPES, TAB)
            .map(b => simpleMerge(b.split(PIPE), PIPE_ESCAPES, PIPE)))))

return data;
$$;


