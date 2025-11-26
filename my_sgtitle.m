function my_sgtitle(titleText, varargin)
    % Custom sgtitle function for older MATLAB versions
    ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 1],'Box','off',...
        'Visible','off','Units','normalized', 'clipping' , 'off');
    text(0.5, 0.98, titleText, 'HorizontalAlignment','center',...
        'VerticalAlignment', 'top', varargin{:});
end