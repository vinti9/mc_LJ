#ifndef GLOBAL_H_INCLUDED
#define GLOBAL_H_INCLUDED

#define X2(a)   (a)*(a)
#define X3(a)   X2(a)*(a)
#define X4(a)   X2(a)*X2(a)
#define X6(a)   X4(a)*X2(a)
#define X12(a)  X6(a)*X6(a)

#define MV_ACC 1
#define MV_REJ -1

#ifndef STDRAND
#include "dSFMT.h"
#endif

extern int is_stdout_redirected;
extern int charmm_units;

typedef struct
{
    int natom ;
    char method[32];
    int nsteps ;

    double d_max ;
    int d_max_when;
    double d_max_tgt;

    double inid ;
    double T ;
    double E_steepD;
    double E_expected;
    double beta;
#ifndef STDRAND
    dsfmt_t dsfmt;
    uint32_t *seeds;
#endif
    double *rn ;
    int nrn ;

} DATA;


typedef struct
{
    int meps;
    int neps;
    double weps;
    double *normalNumbs;
    int normalSize;
} SPDAT;

typedef struct
{
    char sym[4];
    float sig ;
    float eps ;
} LJPARAMS;

typedef struct
{
    float x,y,z ;
    char sym[4] ;
    LJPARAMS ljp;
} ATOM;

#endif // GLOBAL_H_INCLUDED
