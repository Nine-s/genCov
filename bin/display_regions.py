import pandas as pd
import plotly.graph_objects as go
import glob
import os

roi_start = 3088084
roi_end = 3653866
motif = "sorted_*_coverage.bed"
files = glob.glob(motif)

if files:
    file_path = files[0]
    sample_id = os.path.basename(file_path).replace("sorted_", "").replace("_coverage.bed", "")
    
    df = pd.read_csv(file_path, sep='\t', header=None, names=['chrom', 'start', 'end', 'coverage'])
    roi_df = df[(df['start'] >= roi_start) & (df['end'] <= roi_end)]

    fig = go.Figure()

    fig.add_trace(go.Scatter(
        x=roi_df['start'], 
        y=roi_df['coverage'].clip(upper=300), 
        mode='lines', 
        name='Coverage'
    ))

    fig.update_layout(
        title=f'Coverage plot for {sample_id}',
        xaxis_title='Position',
        yaxis_title='Coverage',
        yaxis=dict(range=[0, 300]), 
        template='plotly_white'
    )

    fig.write_html(f"{sample_id}_coverage.html")