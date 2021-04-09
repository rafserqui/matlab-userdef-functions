function [tbl] = stats_summary(x,which_stats,col_names,omit_nans)
    
    % Extract columns of data (a column is a variable)
    [~,cls] = size(x);
    
    % Extract inputs and make defaults if missing
    if  (~exist('which_stats','var')) || (isempty(which_stats))
        which_stats = {'min','mean','median','max','std'};
    end

    if (~exist('col_names','var')) || (isempty(col_names))
        col_names = cell(cls,1);
        opt_add_col_names = true;
    else
        opt_add_col_names = false;
    end
    
    % What to do with nans
    if (~exist('omit_nans','var')) || (isempty(omit_nans))
        opt_omit_nans = false;
    elseif strcmp(omit_nans,'omitnan')
        opt_omit_nans = true;
    else
        error('Choose a correct option for what to do with NaNs.  If nothing, leave empty. If remove the effect of NaNs, choose omitnan')
    end

    % Compute stats by columns
    stats = zeros(cls,length(which_stats)); 

    for col = 1:cls
        if opt_add_col_names
            col_names{col} = ['Col.',num2str(col)];
        end
        
        if opt_omit_nans
            for st = 1:length(which_stats)
                % Create function handle
                ff = str2func(which_stats{st});
                
                % Recall min and max functions dont have omitnan option
                if (strcmp(which_stats{st},'min')) || (strcmp(which_stats{st},'max'))
                    stats(col,st) = ff(x(:,col));
                else
                    stats(col,st) = ff(x(:,col),'omitnan');
                end
            end
        else
            for st = 1:length(which_stats)
                % Create function handle
                ff = str2func(which_stats{st});
                
                stats(col,st) = ff(x(:,col));
            end
        end
    end

    % Create table from stats
    tbl = array2table(stats,'VariableNames',which_stats,'RowNames',col_names);
end