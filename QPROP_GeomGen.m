function [] = QPROP_GeomGen(geom, aero, file)
    N = geom.N;
    R = geom.R;
    c = geom.c;
    beta = geom.beta;

    Cla = aero.Cla; % radians
    CL0 = aero.CL0;
    CLmin = aero.CLmin;
    CLmax = aero.CLmax;
    CD0 = aero.CD0;
    CD2u = aero.CD2u;
    CD2l = aero.CD2l;
    CLCD0 = aero.CLCD0;
    REref = aero.REref;
    REexp = aero.REexp;

    fileID = fopen([file.folder file.filename],'w');
    
    % Print the name of the geometry
    fprintf(fileID, [file.name '\n\n']);

    % Print number of blades
    fprintf(fileID, '%d ! Number of blades\n\n', N);

    % Print lift curve data
    fprintf(fileID, '%.1f  %.2f  ! CL0     CL_a\n', CL0, Cla);
    fprintf(fileID, '%.1f  %.1f  ! CLmin   CLmax\n\n', CLmin, CLmax);


    % Print drag data
    fprintf(fileID, '%.3f  %.3f %.3f %.3f  ! CD0    CD2u   CD2l   CLCD0\n', CD0, CD2u, CD2l, CLCD0);
    fprintf(fileID, '%d  %.2f !  REref  REexp\n\n', REref, REexp);


    switch geom.InputLunits
        case 'inches'
            Rfac = '0.0254';
            Cfac = '0.0254';
        otherwise
            Rfac = '1.0';
            Cfac = '1.0';
    end
    % Print scaling conversions (Naturally in meters)
    fprintf(fileID, [Rfac ' ' Cfac ' 1.0  !  Rfac   Cfac   Bfac\n']);
    fprintf(fileID, '0.0     0.0      0.0  !  Radd   Cadd   Badd\n\n');


    % Print geometry
    fprintf(fileID, '#  r    chord   beta\n');

    for s = 1:length(R)
        fprintf(fileID, '%.3f %.3f %.3f\n', R(s), c(s), beta(s));
    end

end