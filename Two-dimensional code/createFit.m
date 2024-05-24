function [fitresult, gof] = createFit(omega2, P_linear_rad)
%CREATEFIT(OMEGA2,P_LINEAR_RAD)
%  Create a fit.
%
%  Data for 'test_CurveFittingTool' fit:
%      X Input : omega2
%      Y Output: P_linear_rad
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  另请参阅 FIT, CFIT, SFIT.

%  由 MATLAB 于 21-Jun-2022 14:53:35 自动生成


%% Fit: 'test_CurveFittingTool'.
[xData, yData] = prepareCurveData( omega2, P_linear_rad );

% Set up fittype and options.
ft = fittype( 'poly9' );
opts = fitoptions( 'Method', 'LinearLeastSquares' );
opts.Robust = 'Bisquare';

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
%figure( 'Name', 'test_CurveFittingTool' );
%h = plot( fitresult, xData, yData );
%legend( h, 'P_linear_rad vs. omega2', 'test_CurveFittingTool', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
%xlabel( 'omega2', 'Interpreter', 'none' );
%ylabel( 'P_linear_rad', 'Interpreter', 'none' );
%grid on


