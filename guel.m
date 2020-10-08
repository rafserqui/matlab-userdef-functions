function [str] = guel(s,v)
% This function is useful to define "uels" in GAMS.
% It takes the index of the set "s" as a string and 
% it appends the numerical sequence v as a string.
% For example, if a set J with elements j has 100 
% elements, to define the uel j1,j2,...,j100, we 
% use guel('j',1:100)
% 
%       Syntax: [str] = guel(s,v)
%       Inputs: 
%          - s: string that denotes the index of set
%          - v: numerical sequence with the cardinality
%               of the elements.
%       Output: cell array with the sequence of strings
%               naming each element of the set

    str = strcat(s, strsplit(num2str(v)));
end