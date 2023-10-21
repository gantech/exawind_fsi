#! /usr/bin/env python

import csv
import sys
import math 

def linear_interpolation(param, data):
    # Sort the data by the first column
    data.sort(key=lambda row: row[0])

    # Find the two closest points
    for i in range(len(data) - 1):
        if data[i][0] <= param <= data[i + 1][0]:
           s1, r1, p1 = data[i]
           s2, r2, p2 = data[i + 1]
           break

    # Perform linear interpolation
    interpolated_rpm = r1 + ((param - s1) / (s2 - s1)) * (r2 - r1)
    interpolated_pitch = p1 + ((param - s1) / (s2 - s1)) * (p2 - p1)

    return interpolated_rpm, interpolated_pitch

def calc_timesteps(rpm):
    rotdeg = rpm * 360.0 / 60.0
    cfd_dt = 0.25/rotdeg
    ratio = 3*math.ceil(rotdeg) - 30
    openfast_dt = cfd_dt / ratio
    one_rev = math.ceil((60.0 / rpm) / openfast_dt) * openfast_dt

    return cfd_dt, openfast_dt, one_rev

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("This script requires a single wind speed value as an input.")
        exit(1)
    else:
       wind_speed = float(sys.argv[1])
       file_name = "iea15mw_params.csv"
       data = []
       with open(file_name, 'r') as f:
         reader = csv.reader(f)
         next(reader) # skip the header row
         for row in reader:
           speed, rpm, pitch = map(float, row)
           data.append((speed, rpm, pitch))
       designRPM, designPitch = linear_interpolation(wind_speed, data)
       cfdDt, openfastDt, oneRev = calc_timesteps(designRPM)
       print(designRPM, designPitch, f"{cfdDt:.17f}", f"{openfastDt:.17f}", f"{oneRev:.18f}", f"{oneRev*100:.18f}")

