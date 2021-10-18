# Parsing and Escape Handling
The DDEX DSR FlatFile Specification is actually a bit more complicated than just simple
TSV due to the escape handling.  
This has been made even more complicated by DDEX changing
the escape handling between Architecture versions and each specific Profile/Version isn't
locked to a particular Architecture version.  
The result is sources supplying files which need to be processed 
slightly differently depending on how they have interpreted the specification.  
On top of this some sources will define the wrong Architecture version in the file based
on how they have implemented the escapes in the file.

This means that for each new source we will have to investigate their source files with a 
suitably large sample size and figure out which escape approach they have taken and then
ingest the data with a suitable parser.

# Ingestion

To ingest the DDEX DSR files we are doing the following: 
1) Pulling the data in as a single line with no cell delimiting 
into the FlatFile table structure.
2) A UDF is then used to process each line into a temporary DelimitedFile structure.  
The UDF will handle all parsing with regards to the TSV, Pipe Delimiter and Escape handling.
3) Once all lines have been parsed into the temporary DelimitedFile structure standard insert 
statements will be used to populate the Untyped Record Level view of the data.

## Ingestion SQL Files

We have a generic Stored Procedure which can ingest any Profile/Version from any Source.  
Under the covers this Stored Proc will use the IngestConfig table to figure out where data should be written and what UDF Parser to use.  
It will also make use of the Profile/Version specific Stored Procedures for deleting/inserting the Record Type tables in the Untyped schema.

# Untyped

The Untyped Records are build to match the specification. Each field is represented 
as an Array of Strings so that we are not loosing any information.  
An Array od Strings is used instead of a plain String due to the way parsing/escape handling is performed.

# Typed

The Typed Records are built as views currently and there is no gating to reject invalid files
currently.  
This will come in future when we look at integrating correction & validation into the
flow sequence for processing a file.

# Validation

This is currently still in active development and so has been left as views right now to
enabled easy changing of the structure without having to worry about rebuilding data.
Currently this area is doing the following:

1. Record level validation
   1. This is implementing the majority of the basic checks like not null, is decimal, allowed values/pattern
   2. Validation of array items is not handled currently and still being thought about.
   3. More work needs to be done to handle validation between fields within a single record as well
2. Structural Validation
   1. Some early prototype queries are in place for this which is checking the following
      1. Block Record Type Ordering
      2. Block Record Type Minimum Counts
      3. Header/Summary Record Type Ordering
   2. More work needs to happen here to standardise the checks performed and make it more parameterised
   3. Also need to look at potentially implementing some more structural checks if needed
3. Intra Record Validation
   1. This is more complicated and specification dependent. 
   2. Some of the things which we may be looking at here are:
      1. Foreign Key integrity checks between different records
      2. More complicated validation checks which depend on data in other records within the file