-- Copyright (c) 2013, Florent Hedin, Markus Meuwly, and the University of Basel
-- All rights reserved.
-- The 3-clause BSD license is applied to this software.
-- see LICENSE.txt
-- 
-- lj_n_m_ffi.lua
--
-- Provides energy and gradient functions
-- for a modified n-m Lennard Jones potential
--
-- Formula is :
-- V = C * epsilon * [ (sigma/r)^n - (sigma/r)^m ]
-- Where n and m are integers and n>m ; C is a constant depending of both n and m
--
-- See for example : http://www.sklogwiki.org/SklogWiki/index.php/Lennard-Jones_model#n-m_Lennard-Jones_potential
--
-- This file uses FFI, a library embedded with luajit (see http://luajit.org/ and http://luajit.org/ext_ffi.html) 
-- FFI allows a direct interaction with the c structures, making the calculations much faster 
-- than by using the standard lj_n_m.lua file.
--

ffi = require("ffi")
    
ffi.cdef[[
    typedef struct
    {
        char sym[4];
        double sig;
        double eps;
    } LJPARAMS;
    typedef struct
    {
        double x,y,z;
        char sym[4];
        LJPARAMS ljp;
    } ATOM;
    ]]
    
-- parameters to tune for adapting the potential
-- this set is the same than the standard 12,6 potential
local c = 4
local n = 12
local m = 6

-- This function estimates the LJ n-m potential of a whole system
function lj_v_n_m_ffi(natom, at_list, candidate)
          
--     print("natom : ",natom)
--     print("at_list : ",at_list)
       
    local at = ffi.new("ATOM*",at_list)

--     for i=0,natom-1 do
--         print(atl[i].x,atl[i].y,atl[i].z,atl[i].sym,atl[i].ljp.sym,atl[i].ljp.sig,atl[i].ljp.eps)
--     end
    
    local i,j
    local ener = 0.0
    
    if (candidate == -1) then
        for i=0,natom-1
        do
            
            local dx1=at[i].x
            local dy1=at[i].y
            local dz1=at[i].z
            
            for j=i+1,natom-1
            do 
                local dx2=at[j].x
                local dy2=at[j].y
                local dz2=at[j].z
                
                local r = math.sqrt((dx2-dx1)^2 + (dy2-dy1)^2 + (dz2-dz1)^2)
                local eps = math.sqrt( at[i].ljp.eps * at[j].ljp.eps )
                local sig = 0.5*( at[i].ljp.sig + at[j].ljp.sig )
                
                ener = ener + c*eps*(math.pow(sig/r,n)-math.pow(sig/r,m))
            end
        end
    else
        i=candidate
                    
        local dx1=at[i].x
        local dy1=at[i].y
        local dz1=at[i].z
        
        for j=0,natom-1
        do
            if(j~=i) then
                local dx2=at[j].x
                local dy2=at[j].y
                local dz2=at[j].z
                
                local r = math.sqrt((dx2-dx1)^2 + (dy2-dy1)^2 + (dz2-dz1)^2)
                local eps = math.sqrt( at[i].ljp.eps * at[j].ljp.eps )
                local sig = 0.5*( at[i].ljp.sig + at[j].ljp.sig )
                
                ener = ener + c*eps*(math.pow(sig/r,n)-math.pow(sig/r,m))
            end
            
        end
        
    end -- end of if on 'candidate'
    
    return ener
    
end -- end of function

