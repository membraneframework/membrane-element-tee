defmodule Membrane.Element.Tee.Filter do
  use Membrane.Element.Base.Filter

  def_input_pad :input,
    availability: :always,
    mode: :pull,
    demand_unit: :buffers,
    caps: :any

  def_output_pad :output1,
    availability: :always,
    mode: :pull,
    caps: :any

  def_output_pad :output2,
    availability: :always,
    mode: :pull,
    caps: :any

  @impl true
  def handle_process(:input, %Membrane.Buffer{} = buffer, _ctx, state) do
    {{:ok, buffer: {:output1, buffer}, buffer: {:output2, buffer}}, state}
  end

  @impl true
  def handle_demand(:output1, size, _unit, _ctx, state) do
    {{:ok, demand: {:input, size}}, state}
  end

  @impl true
  def handle_demand(:output2, size, _unit, _ctx, state) do
    {{:ok, demand: {:input, size}}, state}
  end
end
